

$BtnVersion_Click = {
    start "https://intranet.egc.wa.edu.au/byod"
}



$BYOD_Load = {

    $BYOD.Visible = $true

	
    $dns_info = Get-WmiObject Win32_NetworkAdapterConfiguration | where { $_.dhcpenabled -eq "true" -and $_.ipenabled -eq "true" }  | select dnsdomain, dnsserversearchorder
   
    try {
        $script:dnsserver_ip = $dns_info.dnsserversearchorder[0]
    }
    catch {
        [System.Windows.Forms.MessageBox]::Show("Error - Not connected to a network `r`n  Fix and restart", "No IP", 'Ok', 'warning')
        $BYOD.Close()
    }

    $script:dnsserver_fqdn = Resolve-DnsName $dnsserver_ip -DnsOnly | Select-Object -ExpandProperty NameHost

    $array = $dnsserver_fqdn.split('.')
    $script:domain_dotted = $array[1] + "." + $array[2] + "." + $array[3]
    $script:domain_dn = "dc=" + $array[1] + ",dc=" + $array[2] + ",dc=" + $array[3]
    $script:domain_short = $array[1]
    $script:site_code = $array[0].substring(0, 8)
	
    # -- lets have a bit of chat

    $BYOD.txtoutput.AppendText("DNS Server IP :   $dnsserver_ip `r`n")
    $BYOD.txtoutput.AppendText("DNS Server Name :   $dnsserver_fqdn `r`n")
    $BYOD.txtoutput.AppendText("Domain :   $domain_dotted `r`n")
    $BYOD.txtoutput.AppendText("Site Code : $site_code `r`n")

    # -- making sure we are on the DET internal network.

    if ($dnsserver_ip.substring(0, 2) -ne "10") {
        [System.Windows.Forms.MessageBox]::Show("Error - Not a DET network address. `r`n  Fix and restart", "Non DET Network", 'Ok', 'warning')
        $BYOD.Close()
    }


    # -- lets get to it

    $script:domain = $null

    # -- check to see if we are already logged into the domain.. just a warning

    if ($env:COMPUTERNAME -ne $env:LOGONSERVER.Substring(2)) {
        [System.Windows.Forms.MessageBox]::Show("Warning ... you are already logged into a domain `r`n Results unpredictable", "Already logged in", 'Ok', 'warning')
    }

    # -- let trash any pre-existing credentials for this domain


    cmdkey /list | ForEach-Object { if ($_ -like "*Target:*" -and $_ -like "*$domain_dotted*") { cmdkey /del:($_ -replace " ", "" -replace "Target:", "") } } |  Write-Host
 
    try {
        $BYOD.txtUsername.Text = (Get-ItemProperty -ErrorAction Stop -Path HKCU:\BYOD).username 
        $sec_txt_Password = (Get-ItemProperty -ErrorAction Stop -Path HKCU:\BYOD).password 
        $sec_password = $sec_txt_Password | ConvertTo-SecureString
        $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($sec_password)
        $BYOD.txtPassword.Text = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
    }
    catch {
        $BYOD.txtUsername.Text = ""
        $BYOD.txtPassword.Text = ""
    }
}


# -------------------------- DO_PRINTERS ---------------------------------------------------

$DO_PRINTERS = {


	   # -- is there a det-byod printers file ?
    
    $det_byod_file = Resolve-DnsName -Name det-byod -Type CNAME | Select-Object -ExpandProperty NameHost
    $det_byod_file = "\\" + $det_byod_file + "\det-byod\det-byod.printers"

    if (Test-Path $det_byod_file) {

        $BYOD.txtoutput.AppendText("`r`n We have a det-byod.printers file `r`n")

        $script:print_server = ""

        $content = Get-Content -Path $det_byod_file -ErrorAction Stop
        foreach ($line in $content) {
            # Split each line into fields using whitespace as the delimiter
            $fields = $line -split '\s+'

            # $fields will now contain an array of fields from the line
              
            if ($fields[0] -ne "#" -and $fields[0] -ne "") {
                if ($script:print_server -eq "") {
                    $script:print_server = $fields[0]
                    $script:FQDN_print_server = $script:print_server
                    if ($FQDN_print_server -notlike "*.$domain_dotted") {          # add the FQDN if required
                        $FQDN_print_server = $FQDN_print_server -replace "$FQDN_print_server", "$FQDN_print_server.$domain_dotted"
                    }
                    $BYOD.txtoutput.AppendText("Default print server   $script:print_server `r`n")

                    # --- add the default printer server to the registry... only if not there previously
                    try {
                         $existing_print_server = Get-ItemPropertyValue -Path HKCU:\BYOD -Name Printserver -ErrorAction Stop
                    }
                    catch {
                         New-ItemProperty -Path "HKCU:\BYOD" -Name Printserver -Value $script:print_server -PropertyType "string"
                    }


                    # -- lets get rid of any pre-existing credentials for this server in credential manager.
                    cmdkey /list | ForEach-Object { if ($_ -like "*Target:*" -and $_ -like "*$script:print_server*") { cmdkey /del:($_ -replace " ", "" -replace "Target:", "") } } |  Write-Host
                }
                else {
                    $print_server = $fields[0]
                    $printer = $fields[1]
                    if ($print_server -notlike "*.$domain_dotted") {
                        $print_server = $print_server + ".$domain_dotted"
                    }
                    $BYOD.txtoutput.AppendText("Adding Printer  $print_server\$printer .... wait ...")
                    Add-Printer -ConnectionName  "\\$print_server\$printer"
                    $BYOD.txtoutput.AppendText(" Done`r`n")
                }
            }
        }
    }
    elseif ($script:need_default_printers) {
        $BYOD.txtoutput.AppendText("We do NOT have a det-byod.printers file `r`n")
    }

    try {
        $script:print_server = Get-ItemPropertyValue -Path HKCU:\BYOD -Name Printserver -ErrorAction Stop
    }
    catch {
        $script:print_server = "$site_code" + "sv006"
        New-ItemProperty -Path "HKCU:\BYOD" -Name Printserver -Value $script:print_server -PropertyType "string" -Force
    }

}

# -------------------------- Get-Auth ---------------------------------------------------


$GET_AUTH = {

    $script:username = $BYOD.txtUsername.Text
    $password = $BYOD.txtPassword.Text
		
    $BYOD.txtoutput.AppendText("Username :   " + $username + "`r`n")
    #	$BYOD.txtoutput.AppendText("Password :   " + $password +  "`r`n")

    # --now to create credentials and add domain to front of username

    $domain_username = $script:domain_short + "\" + $username
    $BYOD.txtoutput.AppendText("Domain\Username :   " + $domain_username + "`r`n") 

    # ---- Lets connect to the Ldap server to if the auth is correct

  
    $script:domain = New-Object System.DirectoryServices.DirectoryEntry("LDAP://$script:dnsserver_fqdn/$domain_dn", $domain_username, $password)

    if ([bool]$domain.distinguishedNameshedname) {
        $BYOD.txtoutput.AppendText("DN  " + $domain.distinguishedName + "`r`n") 
        $arguments = "/add:*.$domain_dotted" , "/user:$domain_username" , "/pass:$password"
        cmdkey.exe  $arguments  | Write-Host
        $sec_password = ConvertTo-SecureString $password -AsPlainText -Force
        $script:credentials = New-Object System.Management.Automation.PSCredential ($domain_username, $sec_password)

        New-Item -Path "HKCU:\BYOD" -Force
        New-ItemProperty -Path "HKCU:\BYOD" -Name Username -Value $username -PropertyType "string" -Force
        $sec_txt_Password = $sec_Password | ConvertFrom-SecureString
        New-ItemProperty -Path "HKCU:\BYOD" -Name Password -Value $sec_txt_Password -PropertyType "string" -Force
    }
    else {
        [System.Windows.Forms.MessageBox]::Show("Username/Password Error", "Authentication Error", 'Ok', 'warning')
        $script:domain = $null
        #		return
    }
}


$BtnAbout_Click = {
    . (Join-Path $PSScriptRoot 'AboutFrm.ps1')""
}


$BtnPrinters_Click = {	
    if (-Not [bool]$domain.distinguishedNameshedname) {
        & $GET_AUTH
    }
	
    if ([bool]$domain.distinguishedNameshedname) {
        . (Join-Path $PSScriptRoot 'PrintersForm.ps1')
    }
}



#   -----------------------  Drives  -----------------------------------------------
	 
$BtnDrives_Click = {

    if (-Not [bool]$domain.distinguishedNameshedname) {
        & $GET_AUTH
    }

    if ([bool]$domain.distinguishedNameshedname) {

        # -- lets connect to ldap server

        $Searcher = New-Object System.DirectoryServices.DirectorySearcher($domain)

        $searcher.Filter = "(&(objectClass=user)(sAMAccountName=$username))"
        $user = $searcher.FindOne()
        #      $BYOD.txtoutput.AppendText("Home Dir :   " + $user.Properties.homedirectory +  "`r`n") 

        # -- remove the mapped drives.. if they are still there

        #    Get-PSDrive I, T, W | Remove-PSDrive  | Write-Host

		
        net use * /delete /y  | Write-Host
	
        # -- Map H drive
    
        $home_dir = $user.Properties.homedirectory
        net use H:  $home_dir   /persistent:no
        $BYOD.txtoutput.AppendText("Mapping Home Dir :   " + $home_dir + "`r`n") 

       # -- is there a det-byod drives file ?

        $det_byod_file = Resolve-DnsName -Name det-byod -Type CNAME | Select-Object -ExpandProperty NameHost
        $det_byod_file = "\\" + $det_byod_file + "\det-byod\det-byod.drives"

         try {
            # Check if the file is accessible
            if (Test-Path -Path $det_byod_file) {
                $content = Get-Content -Path $det_byod_file -ErrorAction Stop
                $BYOD.txtoutput.AppendText("`r`n We have a det-byod.drives file `r`n")

                foreach ($line in $content) {
                    # Split each line into fields using whitespace as the delimiter
                    $fields = $line -split '\s+'

                    # $fields will now contain an array of fields from the line
                    if ($fields[0] -ne "#" -and $fields[0] -ne "") {
                        $fields[1] = $fields[1] -replace "%username%", "$username"
                        $share_path = $fields[1]
                        $share_host = $share_path.Split('\')[2]  
                        $map_drive = $share_path
                        if ($share_host -notlike "*.$domain_dotted") {          # add the FQDN if required
                            $map_drive = $share_path -replace "$share_host", "$share_host.$domain_dotted"
                        }

                        # Check if the server is reachable
                        if (Test-Connection -ComputerName $share_host -Count 1 -Quiet) {
                            try {
                                # Attempt to access the share
                                $null = Get-Item -Path $map_drive -ErrorAction Stop
                                net use $fields[0] $map_drive /persistent:no
                                $BYOD.txtoutput.AppendText("Mapped " + $fields[0] + "  ---->  " +  $map_drive + "`r`n")
                            }
                            catch {
                                $BYOD.txtoutput.AppendText("The share path " + $map_drive + " is not accessible: " + $_.Exception.Message + "`r`n")
                            }
                        }
                        else {
                            $BYOD.txtoutput.AppendText("The server " + $share_host + " is not reachable.`r`n")
                        }
                    }
                }
            }
            else {
                $BYOD.txtoutput.AppendText("The path $det_byod_file is not accessible.`r`n")
                
                # -- NO det byod drives files.. try some defaults

                # -- S drive
                $S_drive = "\\" + $script:site_code + "sv001." + $script:domain_dotted + "\Shared"
                net use S:  $S_drive  /persistent:no
                $BYOD.txtoutput.AppendText("Mapping S: Drive:   " + $S_drive + "`r`n")
            }
        }
        catch {
            $BYOD.txtoutput.AppendText("An error occurred: $_.Exception.Message`r`n")
        }


        #  ------- PRINTERS

        # -- let add this reg key to work around the printnightmare crap

	
        try {
            $cmd = Get-ItemPropertyValue  -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers\PointAndPrint' -Name RestrictDriverInstallationToAdministrators -ErrorAction Stop
            if ($cmd -ne 0) { throw }
        }
        catch {
            $cmd = {
                New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers\PointAndPrint' -Force
                New-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers\PointAndPrint' -Name 'RestrictDriverInstallationToAdministrators' -PropertyType DWORD -Value 0 -Force
            }
            Start-Process -FilePath powershell.exe -ArgumentList $cmd -Verb RunAs -WorkingDirectory C:
        }	

               
        & $DO_PRINTERS

        $BYOD.txtoutput.AppendText("`r`n`n All done`r`n")
    }
 
}





. (Join-Path $PSScriptRoot 'BYOD.designer.ps1')

$BYOD.ShowDialog()