$config = Get-Content '.\config\config.json' | Out-String | ConvertFrom-Json

$sgGroups = Get-ADGroup -Filter * -Properties description -SearchBase $config.SearchBase | ? {$_.Name -like "sg_*" } | select Name, description | sort-object name

ForEach($g in $sgGroups) {
    Write-Host "Security Group: $($g.Name)" -Foreground Green
    Write-Host "Description: $($g.Description)" -Foreground Cyan
    $members = Get-ADGroupMember -Identity $g.Name
    if(($members | measure).Count -ne 0) {
        Write-Host "Members:" -Foreground Yellow
        ForEach($m in $members) {
            Write-Host " -> $($m.name) ($($m.SamAccountName))"
        }
    } else {
        Write-Host "No members" -Foreground Yellow
    }
    Write-Host ""
}