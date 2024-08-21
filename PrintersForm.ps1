
$Lblwarning_Click = {

}

$txtMappedPrinters_TextChanged = {

}

$PrinterscheckedListBox_SelectedIndexChanged = {
}


$btnPrintServerBrowse_Click = {
    $script:print_server = $TxtBoxPrintServer.Text
    $script:FQDN_print_server = $print_server + ".$domain_dotted"
    if (Test-Connection $FQDN_print_server -Count 1 -Quiet) {

        try {
            # Check if the Print Spooler service is running
            $spoolerService = Get-Service -ComputerName $FQDN_print_server -Name 'Spooler'
            if ($spoolerService.Status -eq 'Running') {
                # Clear the CheckedListBox items
                $PrinterscheckedListBox.Items.Clear()

                # Retrieve the list of shared printers from the print server
                $printerList = Get-Printer -ComputerName $FQDN_print_server | Where-Object { $_.shared -eq $true } | Select-Object -ExpandProperty name | Sort-Object

                # Add each printer to the CheckedListBox
                foreach ($printer in $printerList) {
                    $PrinterscheckedListBox.Items.Add($printer)
                }
            }
            else {
                [System.Windows.Forms.MessageBox]::Show("Print Spooler service is not running on $FQDN_print_server", "Service Not Running", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Warning)
            }
        }
        catch {
            [System.Windows.Forms.MessageBox]::Show("Failed check on Print Spooler service on $FQDN_print_server", " Printer Service Check Failed", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Warning)
        }
    }
    else {
        [System.Windows.Forms.MessageBox]::Show("Print Server unreachable", "No Print Server", 'Ok', 'warning')

    }
}


$AddPrintersbutton_Click = {

    foreach ($pussy in $PrinterscheckedListBox.checkeditems) {
        $txtMappedPrinters.AppendText("Adding Printer     $print_server\$pussy .... wait ...")
        $crap = "\\$script:FQDN_print_server\$pussy"
        Add-Printer -ConnectionName  $crap 
        $BYOD.txtoutput.AppendText("Added Printer    $crap ... wait ...")
        $txtMappedPrinters.AppendText("Added Printer    $crap ...wait...")
        $txtMappedPrinters.AppendText("Done `r`n")
        $BYOD.txtoutput.AppendText("Done `r`n")
    }
	
    New-ItemProperty -Path "HKCU:\BYOD" -Name Printserver -Value $TxtBoxPrintServer.Text -PropertyType "string" -Force
    $PrintersForm.close()
    return
}


$PrintersForm_Load = {


    $textBox1.text = @"

Notes:

Wait.... it may take a while to install printer 
drivers.

If you have to allocate a printing cost centre
when printing, you will need to install the 
Papercut Client. See your SBNA.
"@



    try {
        $TxtBoxPrintServer.Text = Get-ItemPropertyValue -Path HKCU:\BYOD -Name Printserver -ErrorAction Stop
    }
    catch {
        $TxtBoxPrintServer.Text = "$site_code" + "sv006"
        New-ItemProperty -Path "HKCU:\BYOD" -Name Printserver -Value $TxtBoxPrintServer.Text -PropertyType "string"
    }
	

    $script:FQDN_print_server = $script:print_server + ".$domain_dotted"

    if (Test-Connection $FQDN_print_server -Count 1 -Quiet) {

        # -- lets get rid of any pre-existing credentials for this server in credential manager.

        cmdkey /list | ForEach-Object { if ($_ -like "*Target:*" -and $_ -like "*$script:print_server*") { cmdkey /del:($_ -replace " ", "" -replace "Target:", "") } } |  Write-Host

        $printerList = Get-Printer  -ComputerName $FQDN_print_server | where shared -EQ $true | select -ExpandProperty name | sort
        foreach ($p in $printerList) {
            $PrinterscheckedListBox.Items.Add($p)
        }

    }
    else {
        [System.Windows.Forms.MessageBox]::Show("Print Server unreachable", "No Print Server", 'Ok', 'warning')

    }


	
    $PrintersForm.visible = $true

	
}

. (Join-Path $PSScriptRoot 'PrintersForm.designer.ps1')

$PrintersForm.ShowDialog()