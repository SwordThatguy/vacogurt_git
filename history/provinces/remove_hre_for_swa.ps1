# Remove "hre = yes" from province history files owned by HES, MAI, FKN, WBG, ANS, Z2J, HAB, BOH
$owners = 'HES','MAI','FKN','WBG','ANS','Z2J','HAB','BOH'
$provinceFiles = Get-ChildItem -Path . -Filter "*.txt" -File
foreach ($file in $provinceFiles) {
    $lines = Get-Content -Path $file.FullName
    if ($lines -match '^(owner = )(' + ($owners -join '|') + ')$') {
        $filtered = $lines | Where-Object { $_ -notmatch '^hre = yes$' }
        if ($filtered.Count -ne $lines.Count) {
            $filtered | Set-Content -Path $file.FullName
            Write-Host "Updated: $($file.Name)"
        }
    }
}
