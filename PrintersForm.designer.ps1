[void][System.Reflection.Assembly]::Load('System.Drawing, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
[void][System.Reflection.Assembly]::Load('System.Windows.Forms, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
$PrintersForm = New-Object -TypeName System.Windows.Forms.Form
[System.Windows.Forms.CheckedListBox]$PrinterscheckedListBox = $null
[System.Windows.Forms.Button]$AddPrintersbutton = $null
[System.Windows.Forms.Label]$LblPrintServer = $null
[System.Windows.Forms.Button]$btnPrintServerBrowse = $null
[System.Windows.Forms.TextBox]$TxtBoxPrintServer = $null
[System.Windows.Forms.TextBox]$txtMappedPrinters = $null
[System.Windows.Forms.TextBox]$textBox1 = $null
[System.Windows.Forms.Button]$button1 = $null
function InitializeComponent
{
$resources = . (Join-Path $PSScriptRoot 'PrintersForm.resources.ps1')
$PrinterscheckedListBox = (New-Object -TypeName System.Windows.Forms.CheckedListBox)
$AddPrintersbutton = (New-Object -TypeName System.Windows.Forms.Button)
$TxtBoxPrintServer = (New-Object -TypeName System.Windows.Forms.TextBox)
$LblPrintServer = (New-Object -TypeName System.Windows.Forms.Label)
$btnPrintServerBrowse = (New-Object -TypeName System.Windows.Forms.Button)
$txtMappedPrinters = (New-Object -TypeName System.Windows.Forms.TextBox)
$textBox1 = (New-Object -TypeName System.Windows.Forms.TextBox)
$PrintersForm.SuspendLayout()
#
#PrinterscheckedListBox
#
$PrinterscheckedListBox.CheckOnClick = $true
$PrinterscheckedListBox.FormattingEnabled = $true
$PrinterscheckedListBox.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]60,[System.Int32]119))
$PrinterscheckedListBox.Name = [System.String]'PrinterscheckedListBox'
$PrinterscheckedListBox.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]613,[System.Int32]256))
$PrinterscheckedListBox.TabIndex = [System.Int32]0
$PrinterscheckedListBox.add_SelectedIndexChanged($PrinterscheckedListBox_SelectedIndexChanged)
#
#AddPrintersbutton
#
$AddPrintersbutton.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]742,[System.Int32]402))
$AddPrintersbutton.Name = [System.String]'AddPrintersbutton'
$AddPrintersbutton.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]168,[System.Int32]46))
$AddPrintersbutton.TabIndex = [System.Int32]1
$AddPrintersbutton.Text = [System.String]'Add Printers'
$AddPrintersbutton.UseVisualStyleBackColor = $true
$AddPrintersbutton.add_Click($AddPrintersbutton_Click)
#
#TxtBoxPrintServer
#
$TxtBoxPrintServer.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]191,[System.Int32]44))
$TxtBoxPrintServer.Name = [System.String]'TxtBoxPrintServer'
$TxtBoxPrintServer.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]365,[System.Int32]26))
$TxtBoxPrintServer.TabIndex = [System.Int32]2
$TxtBoxPrintServer.add_TextChanged($textBox1_TextChanged)
#
#LblPrintServer
#
$LblPrintServer.AutoSize = $true
$LblPrintServer.Font = (New-Object -TypeName System.Drawing.Font -ArgumentList @([System.String]'Microsoft Sans Serif',[System.Single]14.25,[System.Drawing.FontStyle]::Regular,[System.Drawing.GraphicsUnit]::Point,([System.Byte][System.Byte]0)))
$LblPrintServer.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]56,[System.Int32]46))
$LblPrintServer.Name = [System.String]'LblPrintServer'
$LblPrintServer.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]107,[System.Int32]24))
$LblPrintServer.TabIndex = [System.Int32]3
$LblPrintServer.Text = [System.String]'Print Server'
$LblPrintServer.add_Click($label1_Click)
#
#btnPrintServerBrowse
#
$btnPrintServerBrowse.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]654,[System.Int32]45))
$btnPrintServerBrowse.Name = [System.String]'btnPrintServerBrowse'
$btnPrintServerBrowse.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]124,[System.Int32]24))
$btnPrintServerBrowse.TabIndex = [System.Int32]4
$btnPrintServerBrowse.Text = [System.String]'Browse'
$btnPrintServerBrowse.UseVisualStyleBackColor = $true
$btnPrintServerBrowse.add_Click($btnPrintServerBrowse_Click)
#
#txtMappedPrinters
#
$txtMappedPrinters.BackColor = [System.Drawing.SystemColors]::MenuText
$txtMappedPrinters.Font = (New-Object -TypeName System.Drawing.Font -ArgumentList @([System.String]'Microsoft Sans Serif',[System.Single]9.75,[System.Drawing.FontStyle]::Regular,[System.Drawing.GraphicsUnit]::Point,([System.Byte][System.Byte]0)))
$txtMappedPrinters.ForeColor = [System.Drawing.SystemColors]::Info
$txtMappedPrinters.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]60,[System.Int32]389))
$txtMappedPrinters.Multiline = $true
$txtMappedPrinters.Name = [System.String]'txtMappedPrinters'
$txtMappedPrinters.ReadOnly = $true
$txtMappedPrinters.ScrollBars = [System.Windows.Forms.ScrollBars]::Vertical
$txtMappedPrinters.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]613,[System.Int32]73))
$txtMappedPrinters.TabIndex = [System.Int32]5
$txtMappedPrinters.add_TextChanged($txtMappedPrinters_TextChanged)
#
#textBox1
#
$textBox1.BackColor = [System.Drawing.SystemColors]::Control
$textBox1.BorderStyle = [System.Windows.Forms.BorderStyle]::None
$textBox1.Font = (New-Object -TypeName System.Drawing.Font -ArgumentList @([System.String]'Microsoft Sans Serif',[System.Single]9.75,[System.Drawing.FontStyle]::Regular,[System.Drawing.GraphicsUnit]::Point,([System.Byte][System.Byte]0)))
$textBox1.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]695,[System.Int32]193))
$textBox1.Multiline = $true
$textBox1.Name = [System.String]'textBox1'
$textBox1.ReadOnly = $true
$textBox1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]276,[System.Int32]182))
$textBox1.TabIndex = [System.Int32]7
$textBox1.add_TextChanged($textBox1_TextChanged)
#
#PrintersForm
#
$PrintersForm.AcceptButton = $AddPrintersbutton
$PrintersForm.ClientSize = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]1001,[System.Int32]481))
$PrintersForm.Controls.Add($textBox1)
$PrintersForm.Controls.Add($txtMappedPrinters)
$PrintersForm.Controls.Add($btnPrintServerBrowse)
$PrintersForm.Controls.Add($LblPrintServer)
$PrintersForm.Controls.Add($TxtBoxPrintServer)
$PrintersForm.Controls.Add($AddPrintersbutton)
$PrintersForm.Controls.Add($PrinterscheckedListBox)
$PrintersForm.Font = (New-Object -TypeName System.Drawing.Font -ArgumentList @([System.String]'Microsoft Sans Serif',[System.Single]12,[System.Drawing.FontStyle]::Regular,[System.Drawing.GraphicsUnit]::Point,([System.Byte][System.Byte]0)))
$PrintersForm.Icon = ([System.Drawing.Icon]$resources.'$this.Icon')
$PrintersForm.MinimizeBox = $false
$PrintersForm.Name = [System.String]'PrintersForm'
$PrintersForm.add_Load($PrintersForm_Load)
$PrintersForm.ResumeLayout($false)
$PrintersForm.PerformLayout()
Add-Member -InputObject $PrintersForm -Name PrinterscheckedListBox -Value $PrinterscheckedListBox -MemberType NoteProperty
Add-Member -InputObject $PrintersForm -Name AddPrintersbutton -Value $AddPrintersbutton -MemberType NoteProperty
Add-Member -InputObject $PrintersForm -Name LblPrintServer -Value $LblPrintServer -MemberType NoteProperty
Add-Member -InputObject $PrintersForm -Name btnPrintServerBrowse -Value $btnPrintServerBrowse -MemberType NoteProperty
Add-Member -InputObject $PrintersForm -Name TxtBoxPrintServer -Value $TxtBoxPrintServer -MemberType NoteProperty
Add-Member -InputObject $PrintersForm -Name txtMappedPrinters -Value $txtMappedPrinters -MemberType NoteProperty
Add-Member -InputObject $PrintersForm -Name textBox1 -Value $textBox1 -MemberType NoteProperty
Add-Member -InputObject $PrintersForm -Name button1 -Value $button1 -MemberType NoteProperty
}
. InitializeComponent
