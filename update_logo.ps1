$files = Get-ChildItem -Filter *.html

# Regex for HTML files
$patternHTML = '(?s)<div class="logo-wordmark">.*?</div>\s*'

foreach ($f in $files) {
    $content = Get-Content -Raw $f.FullName
    $content = $content -replace $patternHTML, ''
    $content | Set-Content $f.FullName
}

# Update generate_service_pages.ps1
$ps1 = "generate_service_pages.ps1"
if (Test-Path $ps1) {
    $content = Get-Content -Raw $ps1
    
    # Remove block format
    $pattern1 = '(?s)\$html \+= "\s*<div class=`"logo-wordmark`">`n".*?\$html \+= "\s*</div>`n"\s*'
    $content = $content -replace $pattern1, ''
    
    # Remove inline format
    $pattern2 = '\$html \+= "\s*<div class=`"logo-wordmark`">.*?</div>`n"\s*'
    $content = $content -replace $pattern2, ''
    
    $content | Set-Content $ps1
}
