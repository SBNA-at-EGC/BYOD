[void][System.Reflection.Assembly]::Load('System.Drawing, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
[void][System.Reflection.Assembly]::Load('System.Windows.Forms, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
$BYOD = New-Object -TypeName System.Windows.Forms.Form
[System.Windows.Forms.TextBox]$txtOutput = $null
[System.Windows.Forms.TextBox]$txtUsername = $null
[System.Windows.Forms.TextBox]$txtPassword = $null
[System.Windows.Forms.Button]$BtnPrinters = $null
[System.Windows.Forms.Button]$BtnAbout = $null
[System.Windows.Forms.Label]$lblUsername = $null
[System.Windows.Forms.Label]$LblPassword = $null
[System.Windows.Forms.Label]$LblDrives = $null
[System.Windows.Forms.Label]$LblPrinters = $null
[System.Windows.Forms.Button]$BtnCheckVersion = $null
[System.Windows.Forms.Button]$BtnGo = $null
[System.Windows.Forms.Button]$button1 = $null
function InitializeComponent
{
$resources = . (Join-Path $PSScriptRoot 'BYOD.resources.ps1')
$txtOutput = (New-Object -TypeName System.Windows.Forms.TextBox)
$txtUsername = (New-Object -TypeName System.Windows.Forms.TextBox)
$txtPassword = (New-Object -TypeName System.Windows.Forms.TextBox)
$BtnPrinters = (New-Object -TypeName System.Windows.Forms.Button)
$BtnGo = (New-Object -TypeName System.Windows.Forms.Button)
$BtnAbout = (New-Object -TypeName System.Windows.Forms.Button)
$lblUsername = (New-Object -TypeName System.Windows.Forms.Label)
$LblPassword = (New-Object -TypeName System.Windows.Forms.Label)
$LblDrives = (New-Object -TypeName System.Windows.Forms.Label)
$LblPrinters = (New-Object -TypeName System.Windows.Forms.Label)
$BtnCheckVersion = (New-Object -TypeName System.Windows.Forms.Button)
$BYOD.SuspendLayout()
#
#txtOutput
#
$txtOutput.BackColor = [System.Drawing.SystemColors]::ActiveCaptionText
$txtOutput.Font = (New-Object -TypeName System.Drawing.Font -ArgumentList @([System.String]'Microsoft Sans Serif',[System.Single]9.75,[System.Drawing.FontStyle]::Regular,[System.Drawing.GraphicsUnit]::Point,([System.Byte][System.Byte]0)))
$txtOutput.ForeColor = [System.Drawing.SystemColors]::Info
$txtOutput.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]309,[System.Int32]61))
$txtOutput.Multiline = $true
$txtOutput.Name = [System.String]'txtOutput'
$txtOutput.ReadOnly = $true
$txtOutput.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]822,[System.Int32]309))
$txtOutput.TabIndex = [System.Int32]0
$txtOutput.add_TextChanged($txtOutput_TextChanged)
#
#txtUsername
#
$txtUsername.Font = (New-Object -TypeName System.Drawing.Font -ArgumentList @([System.String]'Microsoft Sans Serif',[System.Single]15.75,[System.Drawing.FontStyle]::Regular,[System.Drawing.GraphicsUnit]::Point,([System.Byte][System.Byte]0)))
$txtUsername.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]55,[System.Int32]97))
$txtUsername.Name = [System.String]'txtUsername'
$txtUsername.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]191,[System.Int32]31))
$txtUsername.TabIndex = [System.Int32]2
$txtUsername.add_TextChanged($txtUsername_TextChanged)
#
#txtPassword
#
$txtPassword.Font = (New-Object -TypeName System.Drawing.Font -ArgumentList @([System.String]'Microsoft Sans Serif',[System.Single]15.75,[System.Drawing.FontStyle]::Regular,[System.Drawing.GraphicsUnit]::Point,([System.Byte][System.Byte]0)))
$txtPassword.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]55,[System.Int32]163))
$txtPassword.Name = [System.String]'txtPassword'
$txtPassword.PasswordChar = [System.Char]'*'
$txtPassword.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]191,[System.Int32]31))
$txtPassword.TabIndex = [System.Int32]3
$txtPassword.add_TextChanged($txtPassword_TextChanged)
#
#BtnPrinters
#
$BtnPrinters.BackgroundImage = ([System.Drawing.Image]$resources.'BtnPrinters.BackgroundImage')
$BtnPrinters.BackgroundImageLayout = [System.Windows.Forms.ImageLayout]::Zoom
$BtnPrinters.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]160,[System.Int32]274))
$BtnPrinters.Name = [System.String]'BtnPrinters'
$BtnPrinters.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]104,[System.Int32]96))
$BtnPrinters.TabIndex = [System.Int32]4
$BtnPrinters.UseVisualStyleBackColor = $false
$BtnPrinters.add_Click($BtnPrinters_Click)
#
#BtnGo
#
$BtnGo.BackgroundImage = ([System.Drawing.Image]$resources.'BtnGo.BackgroundImage')
$BtnGo.BackgroundImageLayout = [System.Windows.Forms.ImageLayout]::Zoom
$BtnGo.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]25,[System.Int32]274))
$BtnGo.Name = [System.String]'BtnGo'
$BtnGo.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]103,[System.Int32]96))
$BtnGo.TabIndex = [System.Int32]5
$BtnGo.UseVisualStyleBackColor = $true
$BtnGo.add_Click($BtnDrives_Click)
#
#BtnAbout
#
$BtnAbout.Font = (New-Object -TypeName System.Drawing.Font -ArgumentList @([System.String]'Microsoft Sans Serif',[System.Single]10,[System.Drawing.FontStyle]::Bold,[System.Drawing.GraphicsUnit]::Point,([System.Byte][System.Byte]0)))
$BtnAbout.ForeColor = [System.Drawing.SystemColors]::ControlDarkDark
$BtnAbout.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]641,[System.Int32]386))
$BtnAbout.Name = [System.String]'BtnAbout'
$BtnAbout.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]95,[System.Int32]38))
$BtnAbout.TabIndex = [System.Int32]6
$BtnAbout.Text = [System.String]'About'
$BtnAbout.UseVisualStyleBackColor = $true
$BtnAbout.add_Click($BtnAbout_Click)
#
#lblUsername
#
$lblUsername.AutoSize = $true
$lblUsername.Font = (New-Object -TypeName System.Drawing.Font -ArgumentList @([System.String]'Microsoft Sans Serif',[System.Single]12,[System.Drawing.FontStyle]::Bold,[System.Drawing.GraphicsUnit]::Point,([System.Byte][System.Byte]0)))
$lblUsername.ForeColor = [System.Drawing.SystemColors]::InfoText
$lblUsername.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]93,[System.Int32]70))
$lblUsername.Name = [System.String]'lblUsername'
$lblUsername.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]91,[System.Int32]20))
$lblUsername.TabIndex = [System.Int32]7
$lblUsername.Text = [System.String]'Username'
#
#LblPassword
#
$LblPassword.AutoSize = $true
$LblPassword.Font = (New-Object -TypeName System.Drawing.Font -ArgumentList @([System.String]'Microsoft Sans Serif',[System.Single]12,[System.Drawing.FontStyle]::Bold,[System.Drawing.GraphicsUnit]::Point,([System.Byte][System.Byte]0)))
$LblPassword.ForeColor = [System.Drawing.SystemColors]::InfoText
$LblPassword.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]99,[System.Int32]138))
$LblPassword.Name = [System.String]'LblPassword'
$LblPassword.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]86,[System.Int32]20))
$LblPassword.TabIndex = [System.Int32]8
$LblPassword.Text = [System.String]'Password'
#
#LblDrives
#
$LblDrives.AutoSize = $true
$LblDrives.Font = (New-Object -TypeName System.Drawing.Font -ArgumentList @([System.String]'Microsoft Sans Serif',[System.Single]12,[System.Drawing.FontStyle]::Bold,[System.Drawing.GraphicsUnit]::Point,([System.Byte][System.Byte]0)))
$LblDrives.ForeColor = [System.Drawing.SystemColors]::InfoText
$LblDrives.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]51,[System.Int32]251))
$LblDrives.Name = [System.String]'LblDrives'
$LblDrives.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]33,[System.Int32]20))
$LblDrives.TabIndex = [System.Int32]9
$LblDrives.Text = [System.String]'Go'
$LblDrives.add_Click($LblDrives_Click)
#
#LblPrinters
#
$LblPrinters.AutoSize = $true
$LblPrinters.Font = (New-Object -TypeName System.Drawing.Font -ArgumentList @([System.String]'Microsoft Sans Serif',[System.Single]12,[System.Drawing.FontStyle]::Bold,[System.Drawing.GraphicsUnit]::Point,([System.Byte][System.Byte]0)))
$LblPrinters.ForeColor = [System.Drawing.SystemColors]::InfoText
$LblPrinters.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]172,[System.Int32]251))
$LblPrinters.Name = [System.String]'LblPrinters'
$LblPrinters.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]71,[System.Int32]20))
$LblPrinters.TabIndex = [System.Int32]10
$LblPrinters.Text = [System.String]'Printers'
#
#BtnCheckVersion
#
$BtnCheckVersion.Font = (New-Object -TypeName System.Drawing.Font -ArgumentList @([System.String]'Microsoft Sans Serif',[System.Single]10,[System.Drawing.FontStyle]::Bold,[System.Drawing.GraphicsUnit]::Point,([System.Byte][System.Byte]0)))
$BtnCheckVersion.ForeColor = [System.Drawing.SystemColors]::ControlDarkDark
$BtnCheckVersion.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]405,[System.Int32]386))
$BtnCheckVersion.Name = [System.String]'BtnCheckVersion'
$BtnCheckVersion.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]193,[System.Int32]38))
$BtnCheckVersion.TabIndex = [System.Int32]12
$BtnCheckVersion.Text = [System.String]'Check for New Version'
$BtnCheckVersion.UseVisualStyleBackColor = $true
$BtnCheckVersion.add_Click($BtnVersion_Click)
#
#BYOD
#
$BYOD.ClientSize = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]1162,[System.Int32]476))
$BYOD.Controls.Add($BtnCheckVersion)
$BYOD.Controls.Add($LblPrinters)
$BYOD.Controls.Add($LblDrives)
$BYOD.Controls.Add($LblPassword)
$BYOD.Controls.Add($lblUsername)
$BYOD.Controls.Add($BtnAbout)
$BYOD.Controls.Add($BtnGo)
$BYOD.Controls.Add($BtnPrinters)
$BYOD.Controls.Add($txtPassword)
$BYOD.Controls.Add($txtUsername)
$BYOD.Controls.Add($txtOutput)
$BYOD.Font = (New-Object -TypeName System.Drawing.Font -ArgumentList @([System.String]'Microsoft Sans Serif',[System.Single]15.75,[System.Drawing.FontStyle]::Bold,[System.Drawing.GraphicsUnit]::Point,([System.Byte][System.Byte]0)))
$BYOD.ForeColor = [System.Drawing.SystemColors]::Menu
$BYOD.Icon = ([System.Drawing.Icon]$resources.'$this.Icon')
$BYOD.Name = [System.String]'BYOD'
$BYOD.Text = [System.String]'DET  -- BYOD Access Drives and Printers    Version  19 August 2024'
$BYOD.add_Load($BYOD_Load)
$BYOD.ResumeLayout($false)
$BYOD.PerformLayout()
Add-Member -InputObject $BYOD -Name txtOutput -Value $txtOutput -MemberType NoteProperty
Add-Member -InputObject $BYOD -Name txtUsername -Value $txtUsername -MemberType NoteProperty
Add-Member -InputObject $BYOD -Name txtPassword -Value $txtPassword -MemberType NoteProperty
Add-Member -InputObject $BYOD -Name BtnPrinters -Value $BtnPrinters -MemberType NoteProperty
Add-Member -InputObject $BYOD -Name BtnAbout -Value $BtnAbout -MemberType NoteProperty
Add-Member -InputObject $BYOD -Name lblUsername -Value $lblUsername -MemberType NoteProperty
Add-Member -InputObject $BYOD -Name LblPassword -Value $LblPassword -MemberType NoteProperty
Add-Member -InputObject $BYOD -Name LblDrives -Value $LblDrives -MemberType NoteProperty
Add-Member -InputObject $BYOD -Name LblPrinters -Value $LblPrinters -MemberType NoteProperty
Add-Member -InputObject $BYOD -Name BtnCheckVersion -Value $BtnCheckVersion -MemberType NoteProperty
Add-Member -InputObject $BYOD -Name BtnGo -Value $BtnGo -MemberType NoteProperty
Add-Member -InputObject $BYOD -Name button1 -Value $button1 -MemberType NoteProperty
}
. InitializeComponent
