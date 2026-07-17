$files = Get-ChildItem -Filter *.html

$pattern = '(?s)<a href="index\.html" class="logo-bordered">.*?</a>'
$replacement = '<a href="index.html" class="logo-link"><img src="assets/images/logo.png" alt="ONEDIGIWEB Marketing Solution" class="logo-img"></a>'

foreach ($f in $files) {
    $content = Get-Content -Raw $f.FullName
    $newContent = $content -replace $pattern, $replacement
    Set-Content -Path $f.FullName -Value $newContent
}

$genScript = "generate_service_pages.ps1"
if (Test-Path $genScript) {
    $content = Get-Content -Raw $genScript
    $newContent = $content -replace $pattern, $replacement
    Set-Content -Path $genScript -Value $newContent
}
