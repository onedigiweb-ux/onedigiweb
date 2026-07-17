$htmlFiles = Get-ChildItem -Filter *.html
foreach ($file in $htmlFiles) {
    $content = Get-Content -Raw $file.FullName
    
    $original = $content
    $content = $content.Replace('Ã¢â‚¬â€', '-')
    $content = $content.Replace('Ã‚Â·', '&middot;')
    $content = $content.Replace('Ã¢â€ Â', '&larr;')
    $content = $content.Replace('Ã¢â€ ', '&larr;')
    $content = $content.Replace('â€”', '-')
    $content = $content.Replace('â€“', '-')
    
    if ($content -cne $original) {
        [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
        Write-Host "Fixed mojibake in $($file.Name)"
    }
}
