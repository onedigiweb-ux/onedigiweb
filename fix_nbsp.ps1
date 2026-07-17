$htmlFiles = Get-ChildItem -Filter *.html
foreach ($file in $htmlFiles) {
    $content = Get-Content -Raw $file.FullName
    if ($content -match '&amp;nbsp;&middot;&amp;nbsp;') {
        $updatedContent = $content -replace '&amp;nbsp;&middot;&amp;nbsp;', '&nbsp;&middot;&nbsp;'
        [System.IO.File]::WriteAllText($file.FullName, $updatedContent, [System.Text.Encoding]::UTF8)
        Write-Host "Fixed double-encoded nbsp in $($file.Name)"
    }
}
