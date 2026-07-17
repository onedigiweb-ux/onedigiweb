$htmlFiles = Get-ChildItem -Filter *.html
foreach ($file in $htmlFiles) {
    $content = Get-Content -Raw $file.FullName
    
    # Let's replace the broken portfolio subtitle
    $targetPattern = 'Real projects, real results.*?see what we''ve delivered for our clients'
    $replacement = 'Real projects, real results - see what we''ve delivered for our clients'
    
    if ($content -match $targetPattern) {
        $updatedContent = $content -replace $targetPattern, $replacement
        [System.IO.File]::WriteAllText($file.FullName, $updatedContent, [System.Text.Encoding]::UTF8)
        Write-Host "Fixed portfolio subtitle in $($file.Name)"
    }
}
