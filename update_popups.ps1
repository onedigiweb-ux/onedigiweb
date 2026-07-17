$newPopup = @"
<div class="popup-overlay quote-popup-overlay" id="quotePopup" style="display:none" role="dialog" aria-modal="true" aria-label="Free Strategy Session Form">
  <div class="nq-popup-box">
    <button class="popup-x" id="closeQuotePopup"><i class="fa-solid fa-xmark"></i></button>
    <div class="nq-header">
      <div class="nq-label">FREE SEO CONSULTATION</div>
      <div class="nq-icon-wrap"><i class="fa-solid fa-chart-column"></i></div>
    </div>
    <h3 class="nq-title">Ready to rank higher?</h3>
    
    <form class="nq-form" id="quoteForm" action="https://formsubmit.co/onedigiweb@gmail.com" method="POST">
      <input type="hidden" name="_subject" value="New Lead - FREE SEO Consultation Request" />
      <input type="hidden" name="_captcha" value="false" />
      <input type="hidden" name="_template" value="table" />
      <input type="hidden" name="_next" value="https://onedigiweb.com/thank-you.html" />
      <input type="text" name="_honey" style="display:none" />
      <input type="hidden" name="Submission Date & Time" class="sub-date-time-field" value="" />
      
      <div class="nq-field">
        <input type="text" id="qfName" name="Name" placeholder="Name" required />
      </div>
      <div class="nq-field">
        <input type="email" id="qfEmail" name="Email" placeholder="Email" required />
      </div>
      <div class="nq-field">
        <input type="tel" id="qfPhone" name="Mobile Number" placeholder="Phone" required />
      </div>
      <div class="nq-field">
        <input type="url" id="qfWebsite" name="Website" placeholder="Website" />
      </div>
      
      <button type="submit" class="nq-submit" id="qfSubmitBtn">
        Get a Free SEO Consultation <i class="fa-solid fa-arrow-right"></i>
      </button>
      
      <div class="nq-footer-text">No pressure. No generic sales pitch.</div>
    </form>
  </div>
</div>
"@

foreach ($file in Get-ChildItem *.html) {
    if ($file.Name -ne 'index.html') {
        $content = Get-Content -Raw $file.FullName
        $content = $content -replace '(?s)<div class="popup-overlay quote-popup-overlay" id="quotePopup".*?(?=<!-- Success / Thank You Popup -->)', "$newPopup`r`n`r`n"
        $content | Set-Content $file.FullName
    }
}
