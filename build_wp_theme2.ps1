$sourceDir = "c:\Users\vikky\OneDrive\Desktop\OneDrive\Desktop\digital"
$themeDir = "c:\Users\vikky\OneDrive\Desktop\OneDrive\Desktop\digital\onedigiweb-theme"

# Get index.html content
$indexHtml = Get-Content -Path "$sourceDir\index.html" -Raw

# 3. Process all HTML files into PHP Templates
$htmlFiles = Get-ChildItem -Path $sourceDir -Filter *.html
foreach ($file in $htmlFiles) {
    if ($file.Name -eq "mega_menu_new.html" -or $file.Name -eq "404.html") { continue }
    
    $content = Get-Content -Path $file.FullName -Raw
    
    # Extract middle content (between END COMPONENT: HEADER and <footer class="footer">)
    $middleMatch = [regex]::Match($content, '(?s)<!-- END COMPONENT: HEADER -->(.*?)<footer class="footer">')
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
    } else {
        Write-Host "Failed to match boundaries in $($file.Name)"
    }
}
