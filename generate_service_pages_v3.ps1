$baseDir = "c:\Users\vikky\OneDrive\Desktop\OneDrive\Desktop\digital"

$pages = @(
  @{ slug="seo-services"; icon="[SEO]"; title="SEO Services India | ONEDIGIWEB"; h1="Best SEO Services in India"; h2="Rank #1 on Google with Data-Driven SEO"; meta="ONEDIGIWEB offers professional SEO services in India."; keyword="SEO Company India"; sname="SEO Services" },
  @{ slug="local-seo-services"; icon="[LOCAL]"; title="Local SEO Services India | ONEDIGIWEB"; h1="Local SEO Services in India"; h2="Dominate Local Search Results"; meta="ONEDIGIWEB offers local SEO services in India."; keyword="Local SEO Services India"; sname="Local SEO" },
  @{ slug="technical-seo-services"; icon="[TECH]"; title="Technical SEO Services India | ONEDIGIWEB"; h1="Technical SEO Services in India"; h2="Optimize Your Website Architecture for Google"; meta="ONEDIGIWEB offers technical SEO services in India."; keyword="Technical SEO Services India"; sname="Technical SEO" },
  @{ slug="google-ads-services"; icon="[ADS]"; title="Google Ads Agency India | ONEDIGIWEB"; h1="Google Ads Management Services"; h2="Get Maximum ROI With Professional Google Ads"; meta="ONEDIGIWEB provides expert Google Ads management."; keyword="Google Ads Agency India"; sname="Google Ads" },
  @{ slug="meta-ads-services"; icon="[META]"; title="Meta Ads Agency India | Facebook & Instagram Ads | ONEDIGIWEB"; h1="Meta Ads Management Services"; h2="Drive Conversions with Targeted Facebook & Instagram Ads"; meta="ONEDIGIWEB provides expert Meta Ads management."; keyword="Meta Ads Agency India"; sname="Meta Ads" },
  @{ slug="social-media-marketing"; icon="[SMM]"; title="Social Media Marketing Agency India | ONEDIGIWEB"; h1="Social Media Marketing Services"; h2="Build Your Brand With Powerful SMM"; meta="ONEDIGIWEB offers social media marketing."; keyword="Social Media Marketing Agency India"; sname="Social Media Marketing" },
  @{ slug="website-development"; icon="[WEB]"; title="Website Development Company India | ONEDIGIWEB"; h1="Website Development Company"; h2="Fast, Mobile-First Websites That Convert"; meta="ONEDIGIWEB builds professional websites."; keyword="Website Development Company India"; sname="Website Development" },
  @{ slug="wordpress-development"; icon="[WP]"; title="WordPress Development Services India | ONEDIGIWEB"; h1="WordPress Development Services"; h2="Custom WordPress Websites and Themes"; meta="ONEDIGIWEB offers expert WordPress development."; keyword="WordPress Development India"; sname="WordPress Development" },
  @{ slug="ecommerce-development"; icon="[SHOP]"; title="Ecommerce Website Development India | ONEDIGIWEB"; h1="Ecommerce Website Development"; h2="Build a Powerful Online Store"; meta="ONEDIGIWEB builds professional ecommerce websites."; keyword="Ecommerce Website Development India"; sname="Ecommerce Development" },
  @{ slug="shopify-development"; icon="[SHOPIFY]"; title="Shopify Development Services India | ONEDIGIWEB"; h1="Shopify Store Development Services"; h2="Launch Your Shopify Store With Experts"; meta="ONEDIGIWEB offers expert Shopify development."; keyword="Shopify Developer India"; sname="Shopify Development" },
  @{ slug="graphic-design-services"; icon="[DESIGN]"; title="Graphic Design Services India | ONEDIGIWEB"; h1="Professional Graphic Design Services"; h2="Creative Design Solutions For Your Brand"; meta="ONEDIGIWEB offers professional graphic design."; keyword="Graphic Design Services India"; sname="Graphic Design" },
  @{ slug="logo-design-services"; icon="[LOGO]"; title="Logo Design Services India | ONEDIGIWEB"; h1="Professional Logo Design Services"; h2="Unique and Memorable Logo Designs"; meta="ONEDIGIWEB offers professional logo design."; keyword="Logo Design Services India"; sname="Logo Design" },
  @{ slug="app-development"; icon="[APP]"; title="Mobile App Development Company India | ONEDIGIWEB"; h1="Mobile App Development Company"; h2="Build Powerful iOS and Android Apps"; meta="ONEDIGIWEB develops professional mobile apps."; keyword="App Development Company India"; sname="Mobile App Development" },
  @{ slug="crm-erp-development"; icon="[ERP]"; title="CRM & ERP Development Services India | ONEDIGIWEB"; h1="Custom CRM & ERP Development"; h2="Streamline Your Business Operations"; meta="ONEDIGIWEB develops custom CRM and ERP software."; keyword="CRM ERP Development India"; sname="CRM / ERP Development" }
)

function Make-Page {
  param($p)
  
  $html = @"
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>$($p.title)</title>
  <meta name="description" content="$($p.meta)" />
  <meta name="keywords" content="$($p.keyword)" />
  <meta name="robots" content="index, follow" />
  <link rel="canonical" href="https://onedigiweb.com/$($p.slug).html" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" />
  <link rel="stylesheet" href="style.css?v=3.0" />
  <style>
    .sp-hero { background: linear-gradient(135deg, #0F172A, #1E1035); padding: 120px 0 80px; color: white; }
    .sp-content-section { padding: 80px 0; }
    .sp-overview { background: #f8fafc; }
    .sp-process { background: white; }
    .sp-pricing { background: #f8fafc; }
    .sp-faq { background: white; }
    .section-title { font-size: 32px; font-weight: 800; color: #0F172A; text-align: center; margin-bottom: 40px; }
    
    /* Layout */
    .sp-layout { display: grid; grid-template-columns: 2fr 1fr; gap: 40px; }
    @media (max-width: 992px) { .sp-layout { grid-template-columns: 1fr; } }
    
    /* Content Blocks */
    .sp-box { background: white; border-radius: 12px; padding: 30px; box-shadow: 0 10px 30px rgba(0,0,0,0.05); margin-bottom: 30px; }
    .sp-box h3 { font-size: 24px; font-weight: 800; margin-bottom: 15px; color: var(--p1); }
    .sp-box ul { padding-left: 20px; line-height: 1.8; color: #475569; }
    
    /* Sidebar Form */
    .sp-form-card { background: white; border-radius: 12px; padding: 30px; border-top: 4px solid var(--p1); box-shadow: 0 20px 50px rgba(0,0,0,0.1); position: sticky; top: 100px; }
    .sp-form-card h4 { font-size: 20px; font-weight: 800; margin-bottom: 20px; }
    .sp-input { width: 100%; padding: 12px 16px; border: 1px solid #cbd5e1; border-radius: 8px; margin-bottom: 15px; font-family: inherit; }
    .sp-btn { width: 100%; padding: 15px; background: var(--p1); color: white; border: none; border-radius: 8px; font-weight: 700; cursor: pointer; transition: 0.3s; }
    .sp-btn:hover { background: var(--dark); }
    
    /* CTA Banner */
    .sp-cta-banner { background: var(--p1); color: white; padding: 60px 0; text-align: center; border-radius: 16px; margin: 60px 0; }
    .sp-cta-banner h3 { font-size: 32px; font-weight: 800; margin-bottom: 20px; }
    .sp-cta-banner p { font-size: 18px; margin-bottom: 30px; opacity: 0.9; }
    .btn-white { background: white; color: var(--p1); padding: 14px 28px; border-radius: 50px; font-weight: 700; display: inline-block; text-decoration: none; }
  </style>
</head>
<body>

  <!-- HEADER -->
  <header class="header" id="header">
    <nav class="navbar container">
      <a href="index.html" class="logo-link"><img src="assets/images/logo.png" alt="ONEDIGIWEB Marketing Solution" class="logo-img"></a>
      <ul class="nav-menu">
        <li class="nav-item"><a href="index.html" class="nav-link">Home</a></li>
        <li class="nav-item"><a href="index.html#services" class="nav-link">Services</a></li>
        <li class="nav-item"><a href="index.html#portfolio" class="nav-link">Portfolio</a></li>
        <li class="nav-item"><a href="index.html#contact" class="nav-link">Contact</a></li>
      </ul>
      <div class="nav-cta">
        <a href="tel:+918512821525" class="nav-cta-call"><i class="fa-solid fa-phone"></i> +91 8512821525</a>
        <button class="nav-cta-quote open-quote-trigger"><i class="fa-solid fa-rocket"></i> Free Consultation</button>
      </div>
    </nav>
  </header>

  <!-- HERO -->
  <section class="sp-hero">
    <div class="container">
      <div style="font-size: 14px; opacity: 0.6; margin-bottom: 20px;">Home > Services > $($p.sname)</div>
      <h1 style="font-size: 48px; font-weight: 900; margin-bottom: 20px;">$($p.h1)</h1>
      <h2 style="font-size: 22px; font-weight: 400; opacity: 0.8; margin-bottom: 40px; max-width: 800px;">$($p.h2)</h2>
      <div style="display: flex; gap: 15px;">
        <a href="#inquiry" class="btn-white">Get a Free Quote</a>
        <a href="https://wa.me/918512821525" class="btn-white" style="background:#25D366;color:white;"><i class="fa-brands fa-whatsapp"></i> WhatsApp</a>
      </div>
    </div>
  </section>

  <!-- MAIN CONTENT -->
  <section class="sp-content-section sp-overview">
    <div class="container sp-layout">
      <!-- Left Content -->
      <div class="sp-main">
        
        <div class="sp-box">
          <h3>Overview of $($p.sname)</h3>
          <p>Our $($p.sname) solutions are designed to help your business achieve maximum digital growth. We utilize cutting-edge strategies, data-driven methodologies, and an expert team to ensure you get the best ROI.</p>
        </div>

        <div class="sp-box">
          <h3>Key Features & Benefits</h3>
          <ul>
            <li>Customized strategies tailored to your business goals.</li>
            <li>Transparent reporting and regular performance updates.</li>
            <li>Dedicated account managers providing 24/7 support.</li>
            <li>Data-driven approach to maximize conversion rates.</li>
            <li>Scalable solutions that grow alongside your business.</li>
          </ul>
        </div>

        <div class="sp-box">
          <h3>Our Process</h3>
          <p>We follow a proven 4-step process to deliver success:</p>
          <ol style="padding-left: 20px; line-height: 1.8; color: #475569;">
            <li><strong>Discovery:</strong> Understanding your business, goals, and target audience.</li>
            <li><strong>Strategy:</strong> Developing a customized action plan.</li>
            <li><strong>Execution:</strong> Implementing the strategies with precision.</li>
            <li><strong>Optimization:</strong> Continuous monitoring and refining for better results.</li>
          </ol>
        </div>

        <div class="sp-cta-banner">
          <h3>Ready to Grow Your Business?</h3>
          <p>Partner with ONEDIGIWEB for premium $($p.sname) solutions.</p>
          <a href="tel:+918512821525" class="btn-white"><i class="fa-solid fa-phone"></i> Call +91 8512821525</a>
        </div>

        <div class="sp-box">
          <h3>Frequently Asked Questions</h3>
          <div style="margin-bottom: 20px;">
            <strong>What is the cost of $($p.sname)?</strong>
            <p>Our pricing is highly customizable based on your requirements. Please contact us for a customized quote.</p>
          </div>
          <div>
            <strong>How long does it take to see results?</strong>
            <p>The timeline varies depending on the specific service and your industry, but our team works diligently to deliver fast, sustainable results.</p>
          </div>
        </div>
      </div>

      <!-- Right Sidebar -->
      <div class="sp-sidebar" id="inquiry">
        <div class="sp-form-card">
          <h4>Inquire About $($p.sname)</h4>
          <p style="font-size:14px; color:#64748b; margin-bottom:20px;">Fill out the form below and our team will get back to you within 30 minutes.</p>
          <form action="mailto:onedigiweb@gmail.com?subject=Inquiry for $($p.sname)" method="POST" enctype="text/plain">
            <input type="hidden" name="Service" value="$($p.sname)">
            <input type="text" name="Name" class="sp-input" placeholder="Full Name" required>
            <input type="email" name="Email" class="sp-input" placeholder="Email Address" required>
            <input type="tel" name="Phone" class="sp-input" placeholder="Phone Number" required>
            <textarea name="Message" class="sp-input" placeholder="Tell us about your project..." rows="4" required></textarea>
            <button type="submit" class="sp-btn">Send Inquiry</button>
          </form>
        </div>
      </div>
    </div>
  </section>

</body>
</html>
"@
  
  $filename = "$baseDir\$($p.slug).html"
  Set-Content -Path $filename -Value $html
  Write-Host "Created: $($p.slug).html"
}

foreach ($p in $pages) {
  Make-Page $p
}

Write-Host "`n=== All $($pages.Count) service pages generated successfully! ==="

