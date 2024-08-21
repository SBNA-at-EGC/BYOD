try {
        $cmd = Get-ItemPropertyValue  -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers\PointAndPrint' -Name RestrictDriverInstallationToAdministrators -ErrorAction Stop
		if ($cmd -ne 0) {throw}
	}
	catch {
		$cmd = {
              New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers\PointAndPrint' -Force
	          New-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers\PointAndPrint' -Name 'RestrictDriverInstallationToAdministrators' -PropertyType DWORD -Value 0 -Force
        }
		Start-Process -FilePath powershell.exe -ArgumentList $cmd -verb RunAs -WorkingDirectory C:
	}	 