$AboutFrm_Load = {
	$textBox1.text = @"

	DET - BYOD     

	Version 7 Dec 2023

	Added ability to have site customisations for shares and printers..
	Check Word doc on distribution site.




	Version  2022-5-18

	Fixed the problem that if doing an ad hoc connection to a share it saves the credentials in
	the store, and they take precedence. 

	Tx to Will G for finding this...



	
	Version  2022-4-1

Fixed the print nightmare problem.

Warning . .. works for Windows 10  20H2.  Had problems with 1909.  Run windows update
to get your machine to the latest rev...  A lot depends on DET updating their 006 
print servers ?  Windows 7 ?  No idea.

When first run to add printerr, it will ask for admin privs to set the registry flag 
to allow the installation of the printer drivers WITHOUT admin privs.  Just like 
Windows has done for 20 Years.  Yes. I know..

I made this a permanent setting, so it will only come up once, ever.  Yes... there are 
arguments either way.  Given my target audience, I made the decision that this was
the more preferable way..

 ---- Also added a flag to remember the print server for subsequent runs. For those with Tier 3
      print servers.

	peter.de.groot@education.wa.edu.au                1-April-2022


	
	Version  2022-3-18

Adds shared drives and printers to a windows machine using a local login.

Drives
	H:   My Documents 
	S:   S drive.

Printers
	     Can select Print Server and printers

Can add drives or printers separately, thinking that some people may just
want to add printers, as their stuff may already be stored locally or 
on the cloud.

Site/User info gleaned from DNS/LDAP lookup ... at the moment...

To-do
	1. Save at least the user name locally for subsequent uses. Also the print server...
	2. Add the facility to add extra drives.
	3. Ability for the SBNA to put site specific drives and print servers on a share(?)

Credits.

Original idea and layout by Will Gentch(EGC) as a installer based on python.
Shamelessly pinched and re-written in powershell and distributed as an executable
by Peter de Groot.  Both from EGC.

"@
}

$textBox1_TextChanged = {

}

. (Join-Path $PSScriptRoot 'AboutFrm.designer.ps1')

$AboutFrm.ShowDialog()