$htmlFiles = Get-ChildItem -Filter *.html
$targetRegex = '(?s)<div class="qp-brand">\s*<img src="assets/images/onedigiweb-marketing-solution-logo\.png"[^>]+>\s*<div class="qp-brand-text">\s*<span class="qp-brand-name"[^>]+>ONEDIGIWEB</span>\s*<span class="qp-brand-tag"[^>]+>Marketing Solution</span>\s*</div>\s*</div>'

$replacement = '<div class="qp-brand">
        <img src="assets/images/onedigiweb-marketing-solution-logo.png" alt="ONEDIGIWEB Marketing Solution Logo" title="ONEDIGIWEB Marketing Solution" style="width: 200px; height: auto; max-width: 100%; object-fit: contain;">
      </div>'

foreach ($file in $htmlFiles) {
    $content = Get-Content -Raw $file.FullName
    if ($content -match $targetRegex) {
        $updated = $content -replace $targetRegex, $replacement
        [System.IO.File]::WriteAllText($file.FullName, $updated, [System.Text.Encoding]::UTF8)
        Write-Host "Updated $($file.Name)"
    }
}
