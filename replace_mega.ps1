$html = Get-Content -Raw "index.html"
$newMegaMenu = Get-Content -Raw "mega_menu_new.html"

# Regex to match the entire mega-menu block. It stops at the closing </div> followed by </li>
$pattern = '(?s)<div class="mega-menu" role="menu">.*?</div>\s*</li>'
$replacement = $newMegaMenu + "`n      </li>"

if ($html -match $pattern) {
    $newHtml = $html -replace $pattern, $replacement
    Set-Content -Path "index.html" -Value $newHtml
    Write-Host "Mega menu replaced in index.html"
} else {
    Write-Host "Pattern not found in index.html"
}
