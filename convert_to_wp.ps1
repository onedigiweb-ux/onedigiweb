$sourceDir = "c:\Users\vikky\OneDrive\Desktop\OneDrive\Desktop\digital"
$themeDir = "c:\Users\vikky\OneDrive\Desktop\OneDrive\Desktop\digital\onedigiweb-theme"

# Copy all HTML files to PHP in theme dir
$htmlFiles = Get-ChildItem -Path $sourceDir -Filter *.html
foreach ($file in $htmlFiles) {
    if ($file.Name -eq "mega_menu_new.html") { continue }
    
    $outName = $file.BaseName + ".php"
    if ($file.Name -eq "index.html") {
        $outName = "front-page.php"
    }
    
    $content = Get-Content -Path $file.FullName -Raw
    
    # 1. Update Asset Paths
    $content = $content -replace '(href|src)="assets/', '$1="<?php echo get_template_directory_uri(); ?>/assets/'
    $content = $content -replace 'href="style\.css\?v=[^"]+"', 'href="<?php echo get_stylesheet_uri(); ?>"'
    $content = $content -replace 'src="script\.js\?v=[^"]+"', 'src="<?php echo get_template_directory_uri(); ?>/script.js"'
    
    # 2. Inject WP hooks
    $content = $content -replace '(?i)</head>', "<?php wp_head(); ?>`n</head>"
    $content = $content -replace '(?i)</body>', "<?php wp_footer(); ?>`n</body>"
    
    # 3. Handle <title> tags - let WP manage it, but we can leave the OG tags alone.
    $content = $content -replace '(?i)<title>.*?</title>', ''
    
    # 4. Add Template Header
    if ($outName -ne "front-page.php" -and $outName -ne "404.php") {
        $templateName = (Get-Culture).TextInfo.ToTitleCase($file.BaseName.Replace("-", " "))
        $templateHeader = "<?php`n/**`n * Template Name: $templateName`n */`n?>`n"
        $content = $templateHeader + $content
    }
    
    # Write to theme dir
    Set-Content -Path "$themeDir\$outName" -Value $content -Encoding UTF8
    Write-Host "Created $outName"
}

# Create a generic index.php as fallback
$indexContent = "<?php`n// Fallback template`nwp_redirect(home_url());`nexit;`n?>"
Set-Content -Path "$themeDir\index.php" -Value $indexContent -Encoding UTF8
Write-Host "Created index.php"
