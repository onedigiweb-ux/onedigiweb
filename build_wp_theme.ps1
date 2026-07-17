$sourceDir = "c:\Users\vikky\OneDrive\Desktop\OneDrive\Desktop\digital"
$themeDir = "c:\Users\vikky\OneDrive\Desktop\OneDrive\Desktop\digital\onedigiweb-theme"

# Get index.html content
$indexHtml = Get-Content -Path "$sourceDir\index.html" -Raw

# 1. Extract Header
$headerMatch = [regex]::Match($indexHtml, '(?s)^(.*?)<!-- END COMPONENT: HEADER -->')
if ($headerMatch.Success) {
    $headerContent = $headerMatch.Groups[1].Value + "<!-- END COMPONENT: HEADER -->"
    
    # WP replacements
    $headerContent = $headerContent -replace '<title>.*?</title>', ''
    $headerContent = $headerContent -replace '</head>', "<?php wp_head(); ?>`n</head>"
    $headerContent = $headerContent -replace 'href="style\.css\?v=[^"]+"', 'href="<?php echo get_stylesheet_uri(); ?>"'
    $headerContent = $headerContent -replace '(href|src)="assets/', '$1="<?php echo get_template_directory_uri(); ?>/assets/'
    
    # Body class
    $headerContent = $headerContent -replace '<body(.*?)>', '<body <?php body_class(); ?>>'
    
    Set-Content -Path "$themeDir\header.php" -Value $headerContent -Encoding UTF8
    Write-Host "Created header.php"
}

# 2. Extract Footer
$footerMatch = [regex]::Match($indexHtml, '(?s)<!-- COMPONENT: FOOTER -->(.*?)$')
if ($footerMatch.Success) {
    $footerContent = "<!-- COMPONENT: FOOTER -->" + $footerMatch.Groups[1].Value
    
    # WP replacements
    $footerContent = $footerContent -replace '</body>', "<?php wp_footer(); ?>`n</body>"
    $footerContent = $footerContent -replace '<script src="script\.js\?v=[^"]+"></script>', ''
    $footerContent = $footerContent -replace '(href|src)="assets/', '$1="<?php echo get_template_directory_uri(); ?>/assets/'
    
    Set-Content -Path "$themeDir\footer.php" -Value $footerContent -Encoding UTF8
    Write-Host "Created footer.php"
}

# 3. Process all HTML files into PHP Templates
$htmlFiles = Get-ChildItem -Path $sourceDir -Filter *.html
foreach ($file in $htmlFiles) {
    # Skip mega_menu_new and 404 for now
    if ($file.Name -eq "mega_menu_new.html" -or $file.Name -eq "404.html") { continue }
    
    $content = Get-Content -Path $file.FullName -Raw
    
    # Extract middle content
    $middleMatch = [regex]::Match($content, '(?s)<!-- END COMPONENT: HEADER -->(.*?)<!-- COMPONENT: FOOTER -->')
    if ($middleMatch.Success) {
        $body = $middleMatch.Groups[1].Value
        
        # Update image paths
        $body = $body -replace '(href|src)="assets/', '$1="<?php echo get_template_directory_uri(); ?>/assets/'
        
        $phpTemplate = "<?php get_header(); ?>`n" + $body + "`n<?php get_footer(); ?>"
        
        $outName = ""
        if ($file.Name -eq "index.html") {
            $outName = "front-page.php"
        } elseif ($file.Name -eq "about-us.html") {
            $outName = "template-about.php"
            $phpTemplate = "<?php`n/**`n * Template Name: About Us`n */`n?>`n" + $phpTemplate
        } else {
            # Create as standard template
            $templateName = (Get-Culture).TextInfo.ToTitleCase($file.BaseName.Replace("-", " "))
            $outName = "template-$($file.BaseName).php"
            $phpTemplate = "<?php`n/**`n * Template Name: $templateName`n */`n?>`n" + $phpTemplate
        }
        
        Set-Content -Path "$themeDir\$outName" -Value $phpTemplate -Encoding UTF8
        Write-Host "Created $outName"
    }
}
