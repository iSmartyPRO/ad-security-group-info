$config = Get-Content '.\config\config.json' | Out-String | ConvertFrom-Json

chcp 866
$encoding = [Console]::OutputEncoding
[Console]::OutputEncoding = [System.Text.Encoding]::GetEncoding("cp866")
[Console]::OutputEncoding = $encoding

Add-Content ".\app.log" "$(Get-Date) - Started"

<# Get Data from Active Directory #>
$sgGroups = Get-ADGroup -Filter * -Properties description -SearchBase $config.SearchBase | ? {$_.Name -like "sg_*" } | select Name, description | sort-object name


<# Get rows for table #>
$rows = ""
ForEach($g in $sgGroups) {
    $users = ""
    $members = Get-ADGroupMember -Identity $g.Name
    if(($members | measure).Count -ne 0) {
      $users += "<ul>"
        ForEach($m in $members) {
            $users += "<li>$($m.name) <i>($($m.SamAccountName))</i>;</li>"
        }
      $users += "</ul>"
    }
  $rows += "<tr><td>$($g.Name)</td><td>$($g.Description)</td><td>$($users)</td></tr>"
}

<# Generate HTML for email #>
$EmailBody = @"
<h2>$($config.EmailSubject)</h2>
<table cellpadding="2" cellspacing="0" border="1" style="width: 70%" style="border-collapse: collapse; border: 2px solid #000000;">
 <tr bgcolor="#000000" style="color: #FFFFFF; height: 35px; border-collapse: collapse; border: 2px solid #000000;">
    <td style="text-align: center; font-weight: 700;">Название группы</td>
    <td style="text-align: center; font-weight: 700;">Путь к папке</td>
    <td style="text-align: center; font-weight: 700;">Пользователи</td>
 </tr>
 $($rows)
</table>
"@

<# Setup credentials for email send #>
$secpasswd = ConvertTo-SecureString $config.EmailPassword -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential ($config.EmailUsername, $secpasswd)

<# Send email #>
Send-MailMessage -To $config.EmailTo -From $config.EmailFrom -Subject $config.EmailSubject -Body $EmailBody -Credential $cred -BodyAsHtml -SmtpServer $config.SmtpServer -Encoding $Encoding
Add-Content ".\app.log" "$(Get-Date) - Done"