$htmlFiles = Get-ChildItem -Filter *.html
foreach ($file in $htmlFiles) {
    $content = Get-Content -Raw $file.FullName
    $matches = [regex]::Matches($content, '(?s)[^\x00-\x7F]+')
    if ($matches.Count -gt 0) {
        Write-Host "$($file.Name): Found $($matches.Count) non-ASCII sequences."
        foreach ($m in $matches) {
            # Try to output context around the match
            $idx = $m.Index
            $start = [Math]::Max(0, $idx - 20)
            $len = [Math]::Min($content.Length - $start, 40)
            Write-Host "   Context: $($content.Substring($start, $len).Replace("`n", "\n").Replace("`r", ""))"
        }
    }
}
