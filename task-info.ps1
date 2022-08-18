$config = Get-Content '.\config\config.json' | Out-String | ConvertFrom-Json

$t = Get-ScheduledTask -TaskName $config.TaskName
$t.Actions