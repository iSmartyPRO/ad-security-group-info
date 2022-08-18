$config = Get-Content '.\config\config.json' | Out-String | ConvertFrom-Json
Start-ScheduledTask -TaskName $config.TaskName