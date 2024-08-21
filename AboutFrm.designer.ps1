[void][System.Reflection.Assembly]::Load('System.Drawing, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
[void][System.Reflection.Assembly]::Load('System.Windows.Forms, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
$AboutFrm = New-Object -TypeName System.Windows.Forms.Form
[System.Windows.Forms.TextBox]$textBox1 = $null
[System.Windows.Forms.Button]$button1 = $null
function InitializeComponent
{
$textBox1 = (New-Object -TypeName System.Windows.Forms.TextBox)
$AboutFrm.SuspendLayout()
#
#textBox1
#
$textBox1.BackColor = [System.Drawing.SystemColors]::ActiveCaptionText
$textBox1.ForeColor = [System.Drawing.SystemColors]::ControlLightLight
$textBox1.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]39,[System.Int32]12))
$textBox1.Multiline = $true
$textBox1.Name = [System.String]'textBox1'
$textBox1.ReadOnly = $true
$textBox1.ScrollBars = [System.Windows.Forms.ScrollBars]::Vertical
$textBox1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]646,[System.Int32]746))
$textBox1.TabIndex = [System.Int32]0
$textBox1.add_TextChanged($textBox1_TextChanged)
#
#AboutFrm
#
$AboutFrm.BackColor = [System.Drawing.SystemColors]::ControlLightLight
$AboutFrm.BackgroundImageLayout = [System.Windows.Forms.ImageLayout]::Center
$AboutFrm.ClientSize = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]713,[System.Int32]786))
$AboutFrm.Controls.Add($textBox1)
$AboutFrm.Name = [System.String]'AboutFrm'
$AboutFrm.add_Load($AboutFrm_Load)
$AboutFrm.ResumeLayout($false)
$AboutFrm.PerformLayout()
Add-Member -InputObject $AboutFrm -Name base -Value $base -MemberType NoteProperty
Add-Member -InputObject $AboutFrm -Name textBox1 -Value $textBox1 -MemberType NoteProperty
Add-Member -InputObject $AboutFrm -Name button1 -Value $button1 -MemberType NoteProperty
}
. InitializeComponent
