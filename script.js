/* ═══════════════════════════════════════════════════
   ONEDIGIWEB — Premium JavaScript v2.0
═══════════════════════════════════════════════════ */
'use strict';

document.addEventListener('DOMContentLoaded', () => {
  initCanvas();
  initNav();
  initTypewriter();
  initScrollReveal();
  initCounters();
  initTestimonials();
  initPortfolioFilter();
  initFAQ();
  initForms();
  initPopups();
  initPremiumNewsletterPopup();
  initMegaMenu();
  initBackToTop();
  initSmoothScroll();
  initActiveNav();
  initHeaderScroll();
});

/* ─── HERO CANVAS (Network Lines + Particles) ─── */
function initCanvas() {
  const canvas = document.getElementById('heroCanvas');
  if (!canvas) return;
  const ctx = canvas.getContext('2d');

  function resize() {
    canvas.width = window.innerWidth;
    canvas.height = window.innerHeight;
  }
  resize();
  window.addEventListener('resize', resize, { passive: true });

  // Nodes
  const NODE_COUNT = 70;
  const CONNECT_DIST = 140;
  const nodes = [];

  for (let i = 0; i < NODE_COUNT; i++) {
    nodes.push({
      x: Math.random() * canvas.width,
      y: Math.random() * canvas.height,
      vx: (Math.random() - 0.5) * 0.6,
      vy: (Math.random() - 0.5) * 0.6,
      r: Math.random() * 2.5 + 1,
      color: ['#5B21B6', '#7C3AED', '#06B6D4', '#ffffff'][Math.floor(Math.random() * 4)],
      opacity: Math.random() * 0.6 + 0.2,
    });
  }

  let animId;
  function draw() {
    ctx.clearRect(0, 0, canvas.width, canvas.height);

    // Update + draw nodes
    for (const n of nodes) {
      n.x += n.vx;
      n.y += n.vy;
      if (n.x < 0 || n.x > canvas.width) n.vx *= -1;
      if (n.y < 0 || n.y > canvas.height) n.vy *= -1;

      ctx.beginPath();
      ctx.arc(n.x, n.y, n.r, 0, Math.PI * 2);
      ctx.fillStyle = n.color;
      ctx.globalAlpha = n.opacity;
      ctx.fill();
    }

    // Draw connections
    for (let i = 0; i < nodes.length; i++) {
      for (let j = i + 1; j < nodes.length; j++) {
        const dx = nodes[i].x - nodes[j].x;
        const dy = nodes[i].y - nodes[j].y;
        const dist = Math.sqrt(dx * dx + dy * dy);
        if (dist < CONNECT_DIST) {
          ctx.beginPath();
          ctx.moveTo(nodes[i].x, nodes[i].y);
          ctx.lineTo(nodes[j].x, nodes[j].y);
          const alpha = (1 - dist / CONNECT_DIST) * 0.25;
          ctx.strokeStyle = `rgba(124, 58, 237, ${alpha})`;
          ctx.globalAlpha = 1;
          ctx.lineWidth = 0.8;
          ctx.stroke();
        }
      }
    }

    ctx.globalAlpha = 1;
    animId = requestAnimationFrame(draw);
  }

  // Only run canvas when hero is visible
  const heroObs = new IntersectionObserver(([e]) => {
    if (e.isIntersecting) {
      if (!animId) draw();
    } else {
      cancelAnimationFrame(animId);
      animId = null;
    }
  });
  heroObs.observe(document.querySelector('.hero') || canvas);

  draw();
}

/* ─── NAVIGATION ─────────────────────────────── */
function initNav() {
  const hamburger = document.getElementById('hamburger');
  const navMenu = document.getElementById('navMenu');
  const navOverlay = document.getElementById('navOverlay');

  function openNav() {
    navMenu?.classList.add('open');
    hamburger?.classList.add('active');
    navOverlay?.classList.add('show');
    document.body.style.overflow = 'hidden';
  }
  function closeNav() {
    navMenu?.classList.remove('open');
    hamburger?.classList.remove('active');
    navOverlay?.classList.remove('show');
    document.body.style.overflow = '';
  }

  hamburger?.addEventListener('click', () => navMenu?.classList.contains('open') ? closeNav() : openNav());
  navOverlay?.addEventListener('click', closeNav);
  navMenu?.querySelectorAll('.nav-link').forEach(l => l.addEventListener('click', closeNav));
  navMenu?.querySelectorAll('.mega-link').forEach(l => l.addEventListener('click', closeNav));
}

/* ─── HEADER SCROLL BEHAVIOR ─────────────────── */
function initHeaderScroll() {
  const header = document.getElementById('header');
  if (!header) return;
  header.style.transition = 'transform 0.4s cubic-bezier(0.4,0,0.2,1), box-shadow 0.3s ease';

  let lastY = 0;
  window.addEventListener('scroll', () => {
    const y = window.scrollY;
    if (y > 300) {
      header.style.transform = y > lastY + 5 ? 'translateY(-100%)' : 'translateY(0)';
    } else {
      header.style.transform = 'translateY(0)';
    }
    if (y > 60) header.style.boxShadow = '0 4px 28px rgba(0,0,0,0.1)';
    else header.style.boxShadow = '';
    lastY = y;
  }, { passive: true });
}

/* ─── HERO HEADING SLIDER ────────────────────────── */
function initTypewriter() {
  // Legacy compatibility — calls initHeroSlider
  initHeroSlider();
}

function initHeroSlider() {
  const slides = document.querySelectorAll('.hero-slide');
  const dots = document.querySelectorAll('.hero-dot');
  const prevBtn = document.getElementById('heroPrevBtn');
  const nextBtn = document.getElementById('heroNextBtn');
  const container = document.getElementById('heroSliderContainer');
  
  if (slides.length === 0) return;
  
  let curSlide = 0;
  let timer = null;
  const slideInterval = 5000;
  
  function showSlide(index) {
    slides[curSlide].classList.remove('active');
    dots[curSlide].classList.remove('active');
    
    curSlide = (index + slides.length) % slides.length;
    
    slides[curSlide].classList.add('active');
    dots[curSlide].classList.add('active');
  }
  
  function nextSlide() {
    showSlide(curSlide + 1);
  }
  
  function prevSlide() {
    showSlide(curSlide - 1);
  }
  
  function startAutoSlide() {
    if (!timer) {
      timer = setInterval(nextSlide, slideInterval);
    }
  }
  
  function stopAutoSlide() {
    if (timer) {
      clearInterval(timer);
      timer = null;
    }
  }
  
  prevBtn?.addEventListener('click', () => {
    prevSlide();
    stopAutoSlide();
    startAutoSlide();
  });
  
  nextBtn?.addEventListener('click', () => {
    nextSlide();
    stopAutoSlide();
    startAutoSlide();
  });
  
  dots.forEach((dot, idx) => {
    dot.addEventListener('click', () => {
      showSlide(idx);
      stopAutoSlide();
      startAutoSlide();
    });
  });
  
  container?.addEventListener('mouseenter', stopAutoSlide);
  container?.addEventListener('mouseleave', startAutoSlide);
  
  startAutoSlide();
}



/* ─── SCROLL REVEAL ──────────────────────────── */
function initScrollReveal() {
  const selectors = [
    '.sp-card', '.dms-card', '.wd-card', '.app-card', '.design-card',
    '.why-card', '.port-card', '.blog-card', '.faq-item',
    '.counter-card', '.ah-item', '.av-badge', '.avm-item',
    '.testi-card', '.contact-item',
  ];

  const els = document.querySelectorAll(selectors.join(', '));
  els.forEach((el, i) => {
    el.classList.add('reveal');
    el.classList.add('reveal-d' + ((i % 4) + 1));
  });

  // Section headers
  document.querySelectorAll('.section-header, .about-content-col, .about-visual-col, .consult-info').forEach(el => {
    el.classList.add('reveal');
  });

  const obs = new IntersectionObserver((entries) => {
    entries.forEach(e => {
      if (e.isIntersecting) {
        e.target.classList.add('visible');
        obs.unobserve(e.target);
      }
    });
  }, { threshold: 0.1, rootMargin: '0px 0px -40px 0px' });

  document.querySelectorAll('.reveal').forEach(el => obs.observe(el));
}

/* ─── COUNTER ANIMATION ──────────────────────── */
function initCounters() {
  const cards = document.querySelectorAll('.counter-card[data-count]');
  const obs = new IntersectionObserver(entries => {
    entries.forEach(e => {
      if (!e.isIntersecting) return;
      const card = e.target;
      const target = parseInt(card.dataset.count);
      const suffix = card.dataset.suffix || '';
      const el = card.querySelector('.cc-number');
      if (!el) return;
      let cur = 0;
      const step = target / 70;
      const timer = setInterval(() => {
        cur = Math.min(cur + step, target);
        el.textContent = Math.floor(cur) + suffix;
        if (cur >= target) clearInterval(timer);
      }, 22);
      obs.unobserve(card);
    });
  }, { threshold: 0.5 });
  cards.forEach(c => obs.observe(c));
}

/* ─── TESTIMONIALS SLIDER ────────────────────── */
function initTestimonials() {
  const track = document.getElementById('testiTrack');
  const dotsWrap = document.getElementById('tDots');
  const prevBtn = document.getElementById('tPrev');
  const nextBtn = document.getElementById('tNext');
  if (!track) return;

  const cards = [...track.querySelectorAll('.testi-card')];
  let cur = 0, timer;

  function getVisible() {
    if (window.innerWidth < 768) return 1;
    if (window.innerWidth < 1100) return 2;
    return 3;
  }

  function getMax() { return Math.max(0, cards.length - getVisible()); }

  // Build dots
  function buildDots() {
    dotsWrap.innerHTML = '';
    for (let i = 0; i <= getMax(); i++) {
      const d = document.createElement('div');
      d.className = 'tc-dot' + (i === cur ? ' active' : '');
      d.addEventListener('click', () => goTo(i));
      dotsWrap.appendChild(d);
    }
  }

  function goTo(i) {
    cur = Math.max(0, Math.min(i, getMax()));
    const w = cards[0].offsetWidth + 24;
    track.style.transform = `translateX(-${cur * w}px)`;
    dotsWrap?.querySelectorAll('.tc-dot').forEach((d, j) => d.classList.toggle('active', j === cur));
  }

  function next() { goTo(cur >= getMax() ? 0 : cur + 1); }
  function prev() { goTo(cur <= 0 ? getMax() : cur - 1); }

  prevBtn?.addEventListener('click', prev);
  nextBtn?.addEventListener('click', next);

  // Touch
  let tx = 0;
  track.addEventListener('touchstart', e => { tx = e.touches[0].clientX; }, { passive: true });
  track.addEventListener('touchend', e => {
    const diff = tx - e.changedTouches[0].clientX;
    if (Math.abs(diff) > 50) diff > 0 ? next() : prev();
  });

  function startAuto() { timer = setInterval(next, 4500); }
  function stopAuto() { clearInterval(timer); }
  track.parentElement?.addEventListener('mouseenter', stopAuto);
  track.parentElement?.addEventListener('mouseleave', startAuto);

  buildDots();
  startAuto();
  window.addEventListener('resize', () => { buildDots(); goTo(0); }, { passive: true });
}

/* ─── PORTFOLIO FILTER ───────────────────────── */
function initPortfolioFilter() {
  const tabs = document.querySelectorAll('.ptab');
  const items = document.querySelectorAll('.port-item');

  tabs.forEach(tab => {
    tab.addEventListener('click', () => {
      const filter = tab.dataset.filter;
      tabs.forEach(t => t.classList.remove('active'));
      tab.classList.add('active');
      items.forEach(item => {
        const match = filter === 'all' || item.dataset.cat === filter;
        item.classList.toggle('hidden', !match);
        if (match) item.style.animation = 'none';
      });
    });
  });
}

/* ─── FAQ ACCORDION ──────────────────────────── */
function initFAQ() {
  document.querySelectorAll('.faq-item').forEach(item => {
    item.querySelector('.faq-q')?.addEventListener('click', () => {
      const open = item.classList.contains('open');
      document.querySelectorAll('.faq-item.open').forEach(i => i.classList.remove('open'));
      if (!open) item.classList.add('open');
    });
  });
}

/* ─── FORMS ──────────────────────────────────── */
function initForms() {
  // Consultation Form
  const consultForm = document.getElementById('consultForm');
  const cfSubmitBtn = document.getElementById('cfSubmit');
  
  // Helper for dynamic timezone timestamp
  function setSubmissionDateTime(formEl) {
    const field = formEl.querySelector('.sub-date-time-field');
    if (field) {
      field.value = new Date().toLocaleString('en-IN', { timeZone: 'Asia/Kolkata' });
    }
  }

  consultForm?.addEventListener('submit', e => {
    e.preventDefault();
    
    // Client-side validations
    const nameVal = consultForm.querySelector('[name="Name"]')?.value || '';
    const emailVal = consultForm.querySelector('[name="Email"]')?.value || '';
    const phoneVal = consultForm.querySelector('[name="Phone"]')?.value || '';
    const companyVal = consultForm.querySelector('[name="Company"]')?.value || '';
    const messageVal = consultForm.querySelector('[name="Message"]')?.value || '';
    const serviceVal = consultForm.querySelector('[name="Service"]')?.value || 'N/A';
    
    const emailRe = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    const phoneRe = /^(?:\+91|0)?[6-9]\d{9}$/;
    
    if (!emailRe.test(emailVal)) {
      alert("Please enter a valid email address.");
      return;
    }
    if (phoneVal && !phoneRe.test(phoneVal.replace(/[\s-]/g, ''))) {
      alert("Please enter a valid 10-digit mobile number.");
      return;
    }
    
    // Honeypot spam check
    const honeyVal = consultForm.querySelector('[name="_honey"]')?.value;
    if (honeyVal) {
      console.warn("Spam detected via honeypot.");
      return;
    }

    setSubmissionDateTime(consultForm);

    if (cfSubmitBtn) {
      cfSubmitBtn.disabled = true;
      cfSubmitBtn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Submitting...';
    }

    // Save to localStorage for Admin Panel
    try {
      const inqs = JSON.parse(localStorage.getItem('onedigiweb_inquiries') || '[]');
      inqs.push({
        date: new Date().toLocaleString('en-IN', { timeZone: 'Asia/Kolkata' }),
        name: nameVal,
        phone: phoneVal,
        email: emailVal,
        company: companyVal || 'N/A',
        website: 'N/A',
        service: serviceVal,
        message: messageVal || 'N/A'
      });
      localStorage.setItem('onedigiweb_inquiries', JSON.stringify(inqs));
    } catch(err) { console.error('Failed to save inquiry locally:', err); }

    fetch(consultForm.action, {
      method: 'POST',
      body: new FormData(consultForm),
      headers: {
        'Accept': 'application/json'
      }
    })
    .then(() => {
      const thankYou = document.getElementById('thankYouPopup');
      if (thankYou) {
        thankYou.style.display = 'flex';
        document.body.style.overflow = 'hidden';
      }
      consultForm.reset();
    })
    .catch(err => {
      console.error('Submission error:', err);
      const thankYou = document.getElementById('thankYouPopup');
      if (thankYou) {
        thankYou.style.display = 'flex';
        document.body.style.overflow = 'hidden';
      }
    })
    .finally(() => {
      if (cfSubmitBtn) {
        cfSubmitBtn.disabled = false;
        cfSubmitBtn.innerHTML = 'Get Free Consultation';
      }
    });
  });

  // Newsletter Form
  const nlForm = document.getElementById('nlForm');
  nlForm?.addEventListener('submit', e => {
    e.preventDefault();
    
    // Client-side validations
    const emailVal = nlForm.querySelector('[name="Subscriber Email"]')?.value || nlForm.querySelector('[name="Email"]')?.value || '';
    const emailRe = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (emailVal && !emailRe.test(emailVal)) {
      alert("Please enter a valid email address.");
      return;
    }
    
    // Honeypot spam check
    const honeyVal = nlForm.querySelector('[name="_honey"]')?.value;
    if (honeyVal) {
      console.warn("Spam detected via honeypot.");
      return;
    }

    setSubmissionDateTime(nlForm);
    const nameVal = nlForm.querySelector('[name="Subscriber Name"]')?.value || 'Subscriber';
    const phoneVal = nlForm.querySelector('[name="Subscriber Phone"]')?.value || 'N/A';
    const submitBtn = nlForm.querySelector('button');
    
    if (submitBtn) {
      submitBtn.disabled = true;
      submitBtn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> ...';
    }

    // Save to localStorage for Admin Panel
    try {
      const subs = JSON.parse(localStorage.getItem('onedigiweb_subscribers') || '[]');
      subs.push({
        date: new Date().toLocaleString('en-IN', { timeZone: 'Asia/Kolkata' }),
        name: nameVal,
        email: emailVal,
        phone: phoneVal
      });
      localStorage.setItem('onedigiweb_subscribers', JSON.stringify(subs));
    } catch(err) { console.error('Failed to save subscriber locally:', err); }

    fetch(nlForm.action || 'https://formsubmit.co/onedigiweb@gmail.com', {
      method: 'POST',
      body: new FormData(nlForm),
      headers: {
        'Accept': 'application/json'
      }
    })
    .then(() => {
      if (submitBtn) {
        submitBtn.innerHTML = '✅ Subscribed!';
        submitBtn.style.background = 'linear-gradient(135deg,#10B981,#059669)';
        setTimeout(() => {
          submitBtn.innerHTML = 'Subscribe →';
          submitBtn.style.background = '';
          submitBtn.disabled = false;
        }, 3000);
      }
      nlForm.reset();
    })
    .catch(err => {
      console.error('Newsletter error:', err);
      if (submitBtn) {
        submitBtn.innerHTML = 'Subscribe →';
        submitBtn.disabled = false;
      }
    });
  });
}

/* ─── POPUPS ─────────────────────────────────────── */
function initPopups() {
  // ── Quote / Strategy Popup ──────────────────────
  const quotePopup = document.getElementById('quotePopup');
  const closeQuote = document.getElementById('closeQuotePopup');
  const quoteForm  = document.getElementById('quoteForm');
  const thankYou   = document.getElementById('thankYouPopup');
  const qfSubmit   = document.getElementById('qfSubmitBtn');

  function openQuote() {
    if (quotePopup) { quotePopup.style.display = 'flex'; document.body.style.overflow = 'hidden'; }
  }
  function closeQuoteF() {
    if (quotePopup) { quotePopup.style.display = 'none'; document.body.style.overflow = ''; }
  }
  closeQuote?.addEventListener('click', closeQuoteF);
  quotePopup?.addEventListener('click', e => { if (e.target === quotePopup) closeQuoteF(); });

  // All "openQuotePopup" triggers across page
  document.querySelectorAll('[id="openQuotePopup"], .open-quote-trigger').forEach(el => {
    el.addEventListener('click', openQuote);
  });

  // Dynamic date helper
  function setSubmissionDateTime(form) {
    const field = form.querySelector('.sub-date-time-field');
    if (field) {
      field.value = new Date().toLocaleString('en-IN', { timeZone: 'Asia/Kolkata' });
    }
  }

  // Quote Form submit (Strategy Session)
  quoteForm?.addEventListener('submit', e => {
    e.preventDefault();
    
    // Client-side validations
    const emailVal = quoteForm.querySelector('[name="Email"]')?.value || '';
    const phoneVal = quoteForm.querySelector('[name="Mobile Number"]')?.value || '';
    
    const emailRe = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    const phoneRe = /^(?:\+91|0)?[6-9]\d{9}$/;
    
    if (!emailRe.test(emailVal)) {
      alert("Please enter a valid email address.");
      return;
    }
    if (phoneVal && !phoneRe.test(phoneVal.replace(/[\s-]/g, ''))) {
      alert("Please enter a valid 10-digit mobile number.");
      return;
    }
    
    // Honeypot spam check
    const honeyVal = quoteForm.querySelector('[name="_honey"]')?.value;
    if (honeyVal) {
      console.warn("Spam detected via honeypot.");
      return;
    }

    const nameVal = quoteForm.querySelector('[name="Name"]')?.value || '';
    const companyVal = quoteForm.querySelector('[name="Business Name"]')?.value || 'N/A';
    const websiteVal = quoteForm.querySelector('[name="Website URL"]')?.value || 'N/A';
    const serviceVal = quoteForm.querySelector('[name="Selected Service"]')?.value || 'N/A';
    const messageVal = quoteForm.querySelector('[name="Message"]')?.value || 'N/A';

    setSubmissionDateTime(quoteForm);
    
    if (qfSubmit) {
      qfSubmit.disabled = true;
      qfSubmit.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Submitting...';
    }

    // Save to localStorage for Admin Panel
    try {
      const inqs = JSON.parse(localStorage.getItem('onedigiweb_inquiries') || '[]');
      inqs.push({
        date: new Date().toLocaleString('en-IN', { timeZone: 'Asia/Kolkata' }),
        name: nameVal,
        phone: phoneVal,
        email: emailVal,
        company: companyVal || 'N/A',
        website: websiteVal || 'N/A',
        service: serviceVal,
        message: messageVal || 'N/A'
      });
      localStorage.setItem('onedigiweb_inquiries', JSON.stringify(inqs));
    } catch(err) { console.error('Failed to save inquiry locally:', err); }

    fetch(quoteForm.action, {
      method: 'POST',
      body: new FormData(quoteForm),
      headers: {
        'Accept': 'application/json'
      }
    })
    .then(() => {
      closeQuoteF();
      if (thankYou) { thankYou.style.display = 'flex'; document.body.style.overflow = 'hidden'; }
      quoteForm.reset();
    })
    .catch(err => {
      console.error('Submission error:', err);
      // Fallback close and show TY anyway
      closeQuoteF();
      if (thankYou) { thankYou.style.display = 'flex'; document.body.style.overflow = 'hidden'; }
    })
    .finally(() => {
      if (qfSubmit) {
        qfSubmit.disabled = false;
        qfSubmit.innerHTML = '<i class="fa-solid fa-rocket"></i> Claim My Free Strategy Session';
      }
    });
  });

  // ESC closes quote, thank you
  document.addEventListener('keydown', e => {
    if (e.key === 'Escape') {
      closeQuoteF();
      if (thankYou) { thankYou.style.display = 'none'; document.body.style.overflow = ''; }
    }
  });

}

function initPremiumNewsletterPopup() {
  const popup = document.getElementById('newsletterPopup');
  const closeBtn = document.getElementById('closeNewsletterPopup');
  const form = document.getElementById('newsletterPopupForm');
  const submitBtn = form?.querySelector('button');

  if (!popup || !form) return;

  function closePopup() {
    popup.style.display = 'none';
    document.body.style.overflow = '';
    sessionStorage.setItem('newsletter_popup_closed', Date.now().toString());
  }

  closeBtn?.addEventListener('click', closePopup);
  popup.addEventListener('click', e => {
    if (e.target === popup) closePopup();
  });

  // Check session lockout
  const lastClosed = sessionStorage.getItem('newsletter_popup_closed');
  const showPopup = !lastClosed;

  if (showPopup) {
    setTimeout(() => {
      popup.style.display = 'flex';
      document.body.style.overflow = 'hidden';
    }, 5000); // 5 seconds timer
  }

  form.addEventListener('submit', e => {
    e.preventDefault();

    const nameVal = form.querySelector('[name="Subscriber Name"]')?.value || '';
    const emailVal = form.querySelector('[name="Subscriber Email"]')?.value || '';
    const phoneVal = form.querySelector('[name="Subscriber Phone"]')?.value || '';

    const emailRe = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    const phoneRe = /^(?:\+91|0)?[6-9]\d{9}$/;

    if (!emailRe.test(emailVal)) {
      alert("Please enter a valid email address.");
      return;
    }
    if (phoneVal && !phoneRe.test(phoneVal.replace(/[\s-]/g, ''))) {
      alert("Please enter a valid 10-digit mobile number.");
      return;
    }

    // Honeypot spam check
    const honeyVal = form.querySelector('[name="_honey"]')?.value;
    if (honeyVal) {
      console.warn("Spam detected via honeypot.");
      return;
    }

    if (submitBtn) {
      submitBtn.disabled = true;
      submitBtn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Submitting...';
    }

    // Save to localStorage for Admin Panel
    try {
      const subs = JSON.parse(localStorage.getItem('onedigiweb_subscribers') || '[]');
      subs.push({
        date: new Date().toLocaleString('en-IN', { timeZone: 'Asia/Kolkata' }),
        name: nameVal,
        email: emailVal,
        phone: phoneVal || 'N/A'
      });
      localStorage.setItem('onedigiweb_subscribers', JSON.stringify(subs));
    } catch(err) { console.error('Failed to save subscriber locally:', err); }

    fetch(form.action, {
      method: 'POST',
      body: new FormData(form),
      headers: {
        'Accept': 'application/json'
      }
    })
    .then(() => {
      const formBox = form.closest('.np-card') || form;
      formBox.innerHTML = `
        <div style="text-align:center; padding: 20px 10px;">
          <div style="font-size: 50px; margin-bottom: 15px;">🎉</div>
          <h4 style="font-family: var(--font); font-size: 18px; font-weight: 700; color: var(--dark); margin-bottom: 10px;">Thank you for subscribing!</h4>
          <p style="font-size: 13px; color: var(--gray); line-height: 1.6;">You'll receive our latest marketing updates and special offers in your inbox.</p>
          <button class="btn btn-sm" style="margin-top: 15px; background: var(--p2); color:white; border-radius: 50px; padding: 8px 24px;" onclick="document.getElementById('newsletterPopup').style.display='none'; document.body.style.overflow='';">Close Window</button>
        </div>
      `;
      sessionStorage.setItem('newsletter_popup_closed', Date.now().toString());
    })
    .catch(err => {
      console.error('Subscription error:', err);
      const formBox = form.closest('.np-card') || form;
      formBox.innerHTML = `
        <div style="text-align:center; padding: 20px 10px;">
          <div style="font-size: 50px; margin-bottom: 15px;">🎉</div>
          <h4 style="font-family: var(--font); font-size: 18px; font-weight: 700; color: var(--dark); margin-bottom: 10px;">Thank you for subscribing!</h4>
          <p style="font-size: 13px; color: var(--gray); line-height: 1.6;">You'll receive our latest marketing updates and special offers in your inbox.</p>
          <button class="btn btn-sm" style="margin-top: 15px; background: var(--p2); color:white; border-radius: 50px; padding: 8px 24px;" onclick="document.getElementById('newsletterPopup').style.display='none'; document.body.style.overflow='';">Close Window</button>
        </div>
      `;
      sessionStorage.setItem('newsletter_popup_closed', Date.now().toString());
    });
  });
}

function initMegaMenu() {
  const hasMega = document.querySelector('.has-mega');
  const megaMenu = document.querySelector('.mega-menu');
  let closeTimeout;

  if (!hasMega || !megaMenu) return;

  function openMenu() {
    clearTimeout(closeTimeout);
    hasMega.classList.add('active-menu');
  }

  function closeMenu() {
    clearTimeout(closeTimeout);
    closeTimeout = setTimeout(() => {
      hasMega.classList.remove('active-menu');
    }, 300); // 300ms delay
  }

  // Hover behaviors for desktop
  hasMega.addEventListener('mouseenter', openMenu);
  hasMega.addEventListener('mouseleave', closeMenu);
  megaMenu.addEventListener('mouseenter', openMenu);
  megaMenu.addEventListener('mouseleave', closeMenu);

  // Click behavior for mobile & desktop fallback toggles
  const triggerLink = hasMega.querySelector('.nav-link');
  triggerLink?.addEventListener('click', e => {
    e.preventDefault();
    e.stopPropagation();
    const isOpen = hasMega.classList.contains('active-menu');
    if (isOpen) {
      hasMega.classList.remove('active-menu');
    } else {
      hasMega.classList.add('active-menu');
    }
  });

  // Close when clicking outside
  document.addEventListener('click', e => {
    if (!hasMega.contains(e.target)) {
      hasMega.classList.remove('active-menu');
    }
  });

  // Tabbed Mega Menu Logic (Hover & Click support)
  const tmmTabs = document.querySelectorAll('.tmm-tab');
  const tmmContents = document.querySelectorAll('.tmm-content');

  function switchTab(targetId, activeTab) {
    tmmTabs.forEach(t => t.classList.remove('active'));
    tmmContents.forEach(c => c.classList.remove('active'));
    
    activeTab.classList.add('active');
    const targetContent = document.getElementById(targetId);
    if (targetContent) targetContent.classList.add('active');
  }

  tmmTabs.forEach(tab => {
    const targetId = tab.getAttribute('data-target');
    tab.addEventListener('mouseenter', () => switchTab(targetId, tab));
    tab.addEventListener('click', (e) => {
      e.preventDefault();
      switchTab(targetId, tab);
    });
  });
}

/* ─── BACK TO TOP ────────────────────────────── */
function initBackToTop() {
  const btn = document.getElementById('backTop');
  window.addEventListener('scroll', () => {
    if (btn) btn.style.opacity = window.scrollY > 400 ? '1' : '0.4';
  }, { passive: true });
}

/* ─── SMOOTH SCROLL ──────────────────────────── */
function initSmoothScroll() {
  document.querySelectorAll('a[href^="#"]').forEach(a => {
    a.addEventListener('click', e => {
      const href = a.getAttribute('href');
      if (!href || href === '#') return;
      const target = document.querySelector(href);
      if (target) {
        e.preventDefault();
        const offset = (document.getElementById('header')?.offsetHeight || 80) + 20;
        window.scrollTo({ top: target.getBoundingClientRect().top + window.scrollY - offset, behavior: 'smooth' });
      }
    });
  });
}

/* ─── ACTIVE NAV ON SCROLL ───────────────────── */
function initActiveNav() {
  const sections = document.querySelectorAll('section[id]');
  const links = document.querySelectorAll('.nav-link');
  const obs = new IntersectionObserver(entries => {
    entries.forEach(e => {
      if (e.isIntersecting) {
        links.forEach(l => {
          l.classList.remove('active');
          if (l.getAttribute('href') === `#${e.target.id}`) l.classList.add('active');
        });
      }
    });
  }, { threshold: 0.3, rootMargin: '-80px 0px -60% 0px' });
  sections.forEach(s => obs.observe(s));
}

/* ─── MOBILE STICKY BAR (hide on desktop) ────── */
(function() {
  const bar = document.getElementById('mobileStickyBar');
  if (!bar) return;
  function check() { bar.style.display = window.innerWidth <= 768 ? 'grid' : 'none'; }
  check();
  window.addEventListener('resize', check, { passive: true });
})();

/* ─── TRUST BAR MARQUEE ──────────────────────── */
(function() {
  const items = document.querySelector('.tb-items');
  if (!items || window.innerWidth > 768) return;
  // Simple auto-scroll for mobile
  items.style.overflow = 'hidden';
  items.style.flexWrap = 'nowrap';
  items.style.animation = 'marqueeSlide 20s linear infinite';
  const style = document.createElement('style');
  style.textContent = '@keyframes marqueeSlide { 0% { transform: translateX(0); } 100% { transform: translateX(-50%); } }';
  document.head.appendChild(style);
  // Duplicate items for seamless loop
  items.innerHTML += items.innerHTML;
})();

/* ─── ADD gfab LABEL SHOW ON HOVER ──────────── */
(function() {
  // Fab labels already built-in in HTML, just ensure they show
  document.querySelectorAll('.gfab span').forEach(s => {
    s.style.display = 'inline';
  });
})();

/* ─── PRICING TABS LOGIC ──────────── */
function switchPricing(type) {
  document.querySelectorAll('.pricing-tab').forEach(t => t.classList.remove('active'));
  document.querySelectorAll('.pricing-grid').forEach(g => g.classList.remove('active'));
  
  const btn = document.getElementById('tabBtn' + type.charAt(0).toUpperCase() + type.slice(1));
  const grid = document.getElementById('pricing-' + type);
  
  if (btn) btn.classList.add('active');
  if (grid) grid.classList.add('active');
}
