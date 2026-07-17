$content = Get-Content -Raw index.html

$industriesHTML = @"
<!-- ============================================================
     INDUSTRIES WE SERVE
============================================================ -->
<section class="industries-section section" id="industries">
  <div class="container">
    <div class="section-header text-center">
      <div class="section-pill">Industries</div>
      <h2 class="section-heading">Industries We <span class="grad-text">Serve</span></h2>
      <p class="section-desc">We deliver tailored digital marketing solutions across diverse industries.</p>
    </div>
    <div class="industry-grid">
      <div class="industry-card">
        <div class="industry-icon"><i class="fa-solid fa-house-chimney"></i></div>
        <h3>Real Estate</h3>
      </div>
      <div class="industry-card">
        <div class="industry-icon"><i class="fa-solid fa-stethoscope"></i></div>
        <h3>Healthcare</h3>
      </div>
      <div class="industry-card">
        <div class="industry-icon"><i class="fa-solid fa-cart-shopping"></i></div>
        <h3>E-Commerce</h3>
      </div>
      <div class="industry-card">
        <div class="industry-icon"><i class="fa-solid fa-graduation-cap"></i></div>
        <h3>Education</h3>
      </div>
      <div class="industry-card">
        <div class="industry-icon"><i class="fa-solid fa-rocket"></i></div>
        <h3>Tech Startups</h3>
      </div>
      <div class="industry-card">
        <div class="industry-icon"><i class="fa-solid fa-utensils"></i></div>
        <h3>Hospitality</h3>
      </div>
    </div>
  </div>
</section>

"@

$caseStudiesHTML = @"
<!-- ============================================================
     CASE STUDIES
============================================================ -->
<section class="case-studies-section section" id="casestudies">
  <div class="container">
    <div class="section-header text-center">
      <div class="section-pill">Our Success</div>
      <h2 class="section-heading">Proven <span class="grad-text">Case Studies</span></h2>
      <p class="section-desc">Real results we've achieved for our clients through data-driven strategies.</p>
    </div>
    <div class="cs-grid">
      <!-- Case Study 1 -->
      <div class="cs-card">
        <div class="cs-img"><img src="https://images.unsplash.com/photo-1460925895917-afdab827c52f?q=80&w=600&auto=format&fit=crop" alt="SEO Case Study"></div>
        <div class="cs-content">
          <span class="cs-cat">SEO Optimization</span>
          <h3>National E-Commerce Brand</h3>
          <div class="cs-metric">
            <span class="csm-value">+312%</span>
            <span class="csm-label">Organic Traffic<br>in 6 months</span>
          </div>
          <a href="#" class="cs-link">Read Case Study <i class="fa-solid fa-arrow-right"></i></a>
        </div>
      </div>
      <!-- Case Study 2 -->
      <div class="cs-card">
        <div class="cs-img"><img src="https://images.unsplash.com/photo-1551288049-bebda4e38f71?q=80&w=600&auto=format&fit=crop" alt="PPC Case Study"></div>
        <div class="cs-content">
          <span class="cs-cat">Google Ads</span>
          <h3>Local Healthcare Provider</h3>
          <div class="cs-metric">
            <span class="csm-value">-45%</span>
            <span class="csm-label">Cost Per Acquisition<br>(CPA)</span>
          </div>
          <a href="#" class="cs-link">Read Case Study <i class="fa-solid fa-arrow-right"></i></a>
        </div>
      </div>
      <!-- Case Study 3 -->
      <div class="cs-card">
        <div class="cs-img"><img src="https://images.unsplash.com/photo-1552664730-d307ca884978?q=80&w=600&auto=format&fit=crop" alt="Web Dev Case Study"></div>
        <div class="cs-content">
          <span class="cs-cat">Web Development</span>
          <h3>B2B Tech Startup</h3>
          <div class="cs-metric">
            <span class="csm-value">+185%</span>
            <span class="csm-label">Lead Conversion<br>Rate Increase</span>
          </div>
          <a href="#" class="cs-link">Read Case Study <i class="fa-solid fa-arrow-right"></i></a>
        </div>
      </div>
    </div>
  </div>
</section>

"@

$blogHTML = @"
<!-- ============================================================
     LATEST BLOG
============================================================ -->
<section class="blog-section section" id="blog">
  <div class="container">
    <div class="section-header text-center">
      <div class="section-pill">Insights</div>
      <h2 class="section-heading">Latest <span class="grad-text">Articles</span></h2>
      <p class="section-desc">Stay updated with the latest digital marketing trends and strategies.</p>
    </div>
    <div class="blog-grid">
      <!-- Blog 1 -->
      <div class="blog-card">
        <div class="bc-img">
          <img src="https://images.unsplash.com/photo-1432821596592-e2c18b78144f?q=80&w=600&auto=format&fit=crop" alt="Blog Post">
          <div class="bc-date">12<span>Oct</span></div>
        </div>
        <div class="bc-content">
          <div class="bc-meta">
            <span><i class="fa-solid fa-folder"></i> SEO</span>
            <span><i class="fa-solid fa-user"></i> Admin</span>
          </div>
          <h3><a href="#">The Future of SEO: AI Search & Voice Optimization in 2026</a></h3>
          <p>Discover how artificial intelligence and voice search are fundamentally changing the SEO landscape and how you can prepare.</p>
          <a href="#" class="bc-link">Read More <i class="fa-solid fa-arrow-right"></i></a>
        </div>
      </div>
      <!-- Blog 2 -->
      <div class="blog-card">
        <div class="bc-img">
          <img src="https://images.unsplash.com/photo-1533750349088-cd871a92f312?q=80&w=600&auto=format&fit=crop" alt="Blog Post">
          <div class="bc-date">08<span>Oct</span></div>
        </div>
        <div class="bc-content">
          <div class="bc-meta">
            <span><i class="fa-solid fa-folder"></i> Paid Ads</span>
            <span><i class="fa-solid fa-user"></i> Admin</span>
          </div>
          <h3><a href="#">Maximizing ROI with Google Performance Max Campaigns</a></h3>
          <p>A comprehensive guide on leveraging Google's Performance Max campaigns to drive conversions across all channels.</p>
          <a href="#" class="bc-link">Read More <i class="fa-solid fa-arrow-right"></i></a>
        </div>
      </div>
      <!-- Blog 3 -->
      <div class="blog-card">
        <div class="bc-img">
          <img src="https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?q=80&w=600&auto=format&fit=crop" alt="Blog Post">
          <div class="bc-date">28<span>Sep</span></div>
        </div>
        <div class="bc-content">
          <div class="bc-meta">
            <span><i class="fa-solid fa-folder"></i> Social Media</span>
            <span><i class="fa-solid fa-user"></i> Admin</span>
          </div>
          <h3><a href="#">Building a Community-Driven Social Media Strategy</a></h3>
          <p>Stop broadcasting and start engaging. Learn how to build a loyal brand community on platforms like Instagram and LinkedIn.</p>
          <a href="#" class="bc-link">Read More <i class="fa-solid fa-arrow-right"></i></a>
        </div>
      </div>
    </div>
  </div>
</section>

"@

# Insert Industries after Why Choose Us
$content = $content -replace '(?s)(<section class="why-choose-us section" id="why">.*?</section>\s*)', "`$1$industriesHTML"

# Insert Case Studies before Portfolio
$content = $content -replace '(?s)(<!-- =+[\r\n]+     PORTFOLIO)', "$caseStudiesHTML`$1"

# Insert Blog before Contact
$content = $content -replace '(?s)(<!-- =+[\r\n]+     CONTACT SECTION)', "$blogHTML`$1"

Set-Content -Path index.html -Value $content
