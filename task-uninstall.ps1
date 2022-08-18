$config = Get-Content '.\config\config.json' | Out-String | ConvertFrom-Json
Unregister-ScheduledTask -TaskName $config.TaskName