$content = Get-Content -Raw index.html

$content = $content -replace 'class="mega-categories-grid"', 'class="mega-grid"'
$content = $content -replace 'class="mega-links-list"', 'class="mega-links-grid"'

$ctaOld = '(?s)<!-- Column 5: CTA Card -->.*?</div>\s*</div>\s*</div>\s*</div>\s*</div>\s*</div>\s*</li>'
$ctaNew = @"
                <!-- Column 5: CTA Card -->
                <div class="mega-col" style="justify-content: stretch;">
                  <div class="mega-cta-card">
                    <div>
                      <div class="mega-cta-title">Get a Free Consultation</div>
                      <p style="font-size: 11px; margin-bottom: 12px; line-height: 1.45;">Talk to our experts and grow your business with customized digital marketing solutions.</p>
                    </div>
                    <button class="btn btn-mega-cta open-quote-trigger" onclick="document.getElementById('quotePopup').style.display='flex'"><i class="fa-solid fa-rocket"></i> Get Free Quote</button>
                  </div>
                </div>
              </div>
              
              <!-- Mega Menu Bottom CTA Card -->
              <div class="mega-bottom-bar">
                <div class="mega-bullets">
                  <span><i class="fa-solid fa-circle-check"></i> Free Consultation</span>
                  <span><i class="fa-solid fa-circle-check"></i> 24&times;7 Support</span>
                  <span><i class="fa-solid fa-circle-check"></i> 100% Transparent Pricing</span>
                  <span><i class="fa-solid fa-circle-check"></i> Expert Team</span>
                </div>
                <button class="btn btn-mega-bottom open-quote-trigger" onclick="document.getElementById('quotePopup').style.display='flex'">Book Free Meeting</button>
              </div>
            </div>
          </div>
        </div>
      </li>
"@

$content = $content -replace $ctaOld, $ctaNew
Set-Content -Path index.html -Value $content
