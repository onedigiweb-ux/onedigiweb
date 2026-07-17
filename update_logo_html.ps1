$newLogo = @"
<a href="index.html" class="logo-bordered">
  <div class="logo-icon-wrapper">
    <div class="logo-icon-inner">
      <img src="assets/images/logo.png" alt="ONEDIGIWEB" class="logo-img">
    </div>
  </div>
  <div class="logo-text-wrapper">
    <span class="logo-title">ONEDIGIWEB</span>
    <span class="logo-subtitle">Marketing Solution</span>
  </div>
</a>
"@

$newLogoEscaped = @"
    <a href=`"index.html`" class=`"logo-bordered`" aria-label=`"ONEDIGIWEB Home`">`n      <div class=`"logo-icon-wrapper`"><div class=`"logo-icon-inner`"><img src=`"assets/images/logo.png`" alt=`"ONEDIGIWEB`" class=`"logo-img`"></div></div>`n      <div class=`"logo-text-wrapper`"><span class=`"logo-title`">ONEDIGIWEB</span><span class=`"logo-subtitle`">Marketing Solution</span></div>`n    </a>
"@

foreach ($file in Get-ChildItem *.html) {
    $content = Get-Content -Raw $file.FullName
    $content = $content -replace '(?s)<a [^>]*class="custom-logo"[^>]*>.*?</a>', $newLogo
    $content | Set-Content $file.FullName
}

$ps1 = "generate_service_pages.ps1"
if (Test-Path $ps1) {
    $content = Get-Content -Raw $ps1
    # Pattern to find the custom-logo block in generator script
    $pattern = '(?s)\$html \+= "\s*<a [^>]*class=`"custom-logo`"[^>]*>`n".*?\$html \+= "\s*</a>`n"'
    $replacement = '$html += "' + $newLogoEscaped + '`n"'
    $content = $content -replace $pattern, $replacement
    
    $content | Set-Content $ps1
}
