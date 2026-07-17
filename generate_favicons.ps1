Add-Type -AssemblyName System.Drawing

# ── Paths ──────────────────────────────────────────────────────
$srcPng  = "C:\Users\vikky\.gemini\antigravity\brain\d122b2c8-19e0-431a-a59a-53d7bbf999a4\favicon_master_1782283750427.png"
$ogSrc   = "C:\Users\vikky\.gemini\antigravity\brain\d122b2c8-19e0-431a-a59a-53d7bbf999a4\og_social_image_1782283761571.png"
$favDir  = "c:\Users\vikky\OneDrive\Desktop\OneDrive\Desktop\digital\assets\favicon"
$imgDir  = "c:\Users\vikky\OneDrive\Desktop\OneDrive\Desktop\digital\assets\images"

New-Item -ItemType Directory -Force -Path $favDir | Out-Null
New-Item -ItemType Directory -Force -Path $imgDir  | Out-Null

# ── Helper: Resize a PNG ────────────────────────────────────────
function Resize-Png {
    param([string]$InPath, [string]$OutPath, [int]$Size)
    $src  = [System.Drawing.Image]::FromFile($InPath)
    $bmp  = New-Object System.Drawing.Bitmap($Size, $Size)
    $g    = [System.Drawing.Graphics]::FromImage($bmp)
    $g.InterpolationMode  = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
    $g.SmoothingMode      = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.DrawImage($src, 0, 0, $Size, $Size)
    $bmp.Save($OutPath, [System.Drawing.Imaging.ImageFormat]::Png)
    $g.Dispose(); $bmp.Dispose(); $src.Dispose()
    Write-Host "Created: $OutPath"
}

# ── 1. favicon-32x32.png ───────────────────────────────────────
Resize-Png -InPath $srcPng -OutPath "$favDir\favicon-32x32.png" -Size 32

# ── 2. favicon-16x16.png ───────────────────────────────────────
Resize-Png -InPath $srcPng -OutPath "$favDir\favicon-16x16.png" -Size 16

# ── 3. apple-touch-icon.png (180x180) ─────────────────────────
Resize-Png -InPath $srcPng -OutPath "$favDir\apple-touch-icon.png" -Size 180

# ── 4. android-chrome-192x192.png ─────────────────────────────
Resize-Png -InPath $srcPng -OutPath "$favDir\android-chrome-192x192.png" -Size 192

# ── 5. android-chrome-512x512.png ─────────────────────────────
Resize-Png -InPath $srcPng -OutPath "$favDir\android-chrome-512x512.png" -Size 512

# ── 6. favicon.ico (multi-size: 16, 32, 48) ───────────────────
function Create-Ico {
    param([string]$SourcePng, [string]$IcoPath, [int[]]$Sizes)

    $pngBytes = @{}
    foreach ($sz in $Sizes) {
        $bmp = New-Object System.Drawing.Bitmap($sz, $sz)
        $g   = [System.Drawing.Graphics]::FromImage($bmp)
        $g.InterpolationMode  = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
        $g.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
        $src = [System.Drawing.Image]::FromFile($SourcePng)
        $g.DrawImage($src, 0, 0, $sz, $sz)
        $ms  = New-Object System.IO.MemoryStream
        $bmp.Save($ms, [System.Drawing.Imaging.ImageFormat]::Png)
        $pngBytes[$sz] = $ms.ToArray()
        $g.Dispose(); $bmp.Dispose(); $src.Dispose(); $ms.Dispose()
    }

    $fs     = New-Object System.IO.FileStream($IcoPath, [System.IO.FileMode]::Create)
    $writer = New-Object System.IO.BinaryWriter($fs)

    $writer.Write([uint16]0)
    $writer.Write([uint16]1)
    $writer.Write([uint16]$Sizes.Count)

    $offset = 6 + ($Sizes.Count * 16)
    foreach ($sz in $Sizes) {
        $data = $pngBytes[$sz]
        if ($sz -ge 256) { $wh = [byte]0 } else { $wh = [byte]$sz }
        $writer.Write($wh)
        $writer.Write($wh)
        $writer.Write([byte]0)
        $writer.Write([byte]0)
        $writer.Write([uint16]1)
        $writer.Write([uint16]32)
        $writer.Write([uint32]$data.Length)
        $writer.Write([uint32]$offset)
        $offset += $data.Length
    }

    foreach ($sz in $Sizes) {
        $writer.Write($pngBytes[$sz])
    }

    $writer.Dispose(); $fs.Dispose()
    Write-Host "Created ICO: $IcoPath"
}

Create-Ico -SourcePng $srcPng -IcoPath "$favDir\favicon.ico" -Sizes @(16, 32, 48)

# ── 7. Copy OG image ───────────────────────────────────────────
Copy-Item -Path $ogSrc -Destination "$imgDir\og-image.png" -Force
Write-Host "Copied OG image"

# ── 8. Logo PNG 512px ─────────────────────────────────────────
Resize-Png -InPath $srcPng -OutPath "$imgDir\logo.png" -Size 512

# ── 9. webmanifest ─────────────────────────────────────────────
$manifest = '{
  "name": "ONEDIGIWEB Marketing Solution",
  "short_name": "ONEDIGIWEB",
  "icons": [
    { "src": "/assets/favicon/android-chrome-192x192.png", "sizes": "192x192", "type": "image/png" },
    { "src": "/assets/favicon/android-chrome-512x512.png", "sizes": "512x512", "type": "image/png" }
  ],
  "theme_color": "#5B21B6",
  "background_color": "#0F172A",
  "display": "standalone"
}'
$manifest | Out-File -FilePath "$favDir\site.webmanifest" -Encoding UTF8
Write-Host "Created webmanifest"

Write-Host ""
Write-Host "=== All favicon and image assets generated successfully! ==="
Write-Host "Favicon directory: $favDir"
Write-Host "Images directory:  $imgDir"
