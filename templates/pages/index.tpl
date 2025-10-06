{* templates/pages/index.tpl *}
{extends file="../layouts/default.tpl"}

{block name="title"}{$site.title|escape}{/block}
{block name="meta_description"}{$site.description|escape}{/block}

{* OGPなど、必要に応じて差し替え *}
{block name="head_append"}
  {if isset($site.ogp_image) && $site.ogp_image != ''}
    <meta property="og:image" content="{$site.ogp_image|escape}" />
  {/if}
  <link rel="preload" as="image"
        href="{$assets.kv_2x|escape}"
        imagesrcset="{$assets.kv|escape} 1x, {$assets.kv_2x|escape} 2x" />
  <link rel="stylesheet" href="{$assets.css_reset|escape}" />
  <link rel="stylesheet" href="{$assets.css_app|escape}" />
  <link rel="stylesheet" href="./css/style.css" />
  
{/block}

{block name="content"}

  {* Header *}
  <header aria-label="ヘッダー">
    <div class="container header-inner">
      <a class="brand" href="{$site.baseUrl|default:'/'|escape}" aria-label="トップへ">
        {if isset($brand.logo) && $brand.logo != ''}
          <img src="{$brand.logo|escape}" alt="{$brand.name|escape}" width="120" height="28" />
        {/if}
        <span>{$brand.name|escape}</span>
        {if isset($campaign.is_ended) && $campaign.is_ended}
          <span class="label label--end" role="status">ENDED</span>
        {elseif isset($campaign.is_new) && $campaign.is_new}
          <span class="label label--new" role="status">NEW</span>
        {/if}
      </a>

      <nav aria-label="メインナビゲーション">
        {if !(isset($campaign.is_ended) && $campaign.is_ended)}
          <a class="cta" href="#entry" aria-label="今すぐエントリー">今すぐエントリー</a>
        {else}
          {if isset($campaign.archive_url) && $campaign.archive_url != ''}
            <a class="cta cta--ghost" href="{$campaign.archive_url|escape}">アーカイブを見る</a>
          {/if}
        {/if}
      </nav>
    </div>
  </header>

  {* Hero *}
  <section class="hero" aria-labelledby="hero-title">
    <div class="container hero-inner">
      <div>
        <h1 id="hero-title">
          {if isset($hero.title) && $hero.title != ''}{$hero.title|escape}{else}FASHION HOLIDAY CAMPAIGN{/if}
        </h1>
        {if isset($hero.subtitle) && $hero.subtitle != ''}
          <p class="sub">{$hero.subtitle|escape}</p>
        {/if}

        {if isset($campaign.is_ended) && $campaign.is_ended}
          <div class="card" role="alert" style="margin-top:12px">
            <strong>⚠️ キャンペーンは終了しました。</strong><br />
            {if isset($campaign.ended_message) && $campaign.ended_message != ''}{$campaign.ended_message|escape}{/if}
          </div>
        {else}
          {if isset($campaign.copy) && $campaign.copy != ''}
            <p class="sub"><strong>{$campaign.copy|escape}</strong></p>
          {/if}
          
          {* カウントダウンタイマー（期間がある場合） *}
          {if isset($campaign.end_date) && $campaign.end_date != ''}
            <div class="countdown" id="countdown" data-end-date="{$campaign.end_date|escape}" aria-live="polite">
              <div class="countdown-item">
                <span class="countdown-value" id="days">00</span>
                <span class="countdown-label">日</span>
              </div>
              <div class="countdown-item">
                <span class="countdown-value" id="hours">00</span>
                <span class="countdown-label">時間</span>
              </div>
              <div class="countdown-item">
                <span class="countdown-value" id="minutes">00</span>
                <span class="countdown-label">分</span>
              </div>
              <div class="countdown-item">
                <span class="countdown-value" id="seconds">00</span>
                <span class="countdown-label">秒</span>
              </div>
            </div>
          {/if}
          
          {if isset($campaign.period) && $campaign.period != ''}
            <ul class="note" style="margin-top:16px" aria-label="キャンペーン概要">
              <li>📅 実施期間：{$campaign.period|escape}</li>
            </ul>
          {/if}
          <p style="margin-top:20px">
            <a class="cta" href="#entry">🎁 エントリーして特典を受け取る</a>
          </p>
        {/if}
      </div>

      <figure class="kv">
        <img src="{$assets.kv|escape}"
             srcset="{$assets.kv|escape} 1x, {$assets.kv_2x|escape} 2x"
             alt="{if isset($hero.kv_alt) && $hero.kv_alt != ''}{$hero.kv_alt|escape}{else}キャンペーンKV{/if}"
             width="800" height="520" loading="eager" />
      </figure>
    </div>
  </section>

  {* Features（ファッション系の打ち出し） *}
  {if isset($features) && $features|@count > 0}
  <section class="section" id="features" aria-labelledby="features-title">
    <div class="container">
      <h2 id="features-title">{if isset($sections.features_title) && $sections.features_title != ''}{$sections.features_title|escape}{else}✨ 選ばれる理由{/if}</h2>
      <div class="grid-3">
        {foreach $features as $f name=feature}
          <article class="card" role="article" aria-labelledby="feature-{$smarty.foreach.feature.index}">
            <h3 id="feature-{$smarty.foreach.feature.index}">{$f.title|escape}</h3>
            {if isset($f.text) && $f.text != ''}<p>{$f.text|escape}</p>{/if}
          </article>
        {/foreach}
      </div>
    </div>
  </section>
  {/if}

  {* Campaign detail *}
  <section class="section" id="campaign" aria-labelledby="campaign-title">
    <div class="container">
      <h2 id="campaign-title">{if isset($sections.detail_title) && $sections.detail_title != ''}{$sections.detail_title|escape}{else}📋 キャンペーン詳細{/if}</h2>
      <div class="details" role="region" aria-labelledby="campaign-title">
        <dl>
          {if isset($campaign.details) && $campaign.details|@count > 0}
            {foreach $campaign.details as $d}
              <dt>{$d.term|escape}</dt><dd>{$d.value|escape}</dd>
            {/foreach}
          {else}
            {if isset($campaign.period) && $campaign.period != ''}<dt>期間</dt><dd>{$campaign.period|escape}</dd>{/if}
            {if isset($campaign.benefit) && $campaign.benefit != ''}<dt>特典</dt><dd>{$campaign.benefit|escape}</dd>{/if}
          {/if}
        </dl>
      </div>
      {if isset($campaign.note) && $campaign.note != ''}<p class="note" style="margin-top:16px">⚠️ {$campaign.note|escape}</p>{/if}
    </div>
  </section>

  {* Entry（終了時は非表示 or メッセージ差替え） *}
  <section class="section" id="entry" aria-labelledby="entry-title">
    <div class="container">
      <h2 id="entry-title">🎯 今すぐエントリー</h2>

      {if isset($campaign.is_ended) && $campaign.is_ended}
        <div class="card">
          <p><strong>本キャンペーンのエントリー受付は終了しました。</strong></p>
          <p style="margin-top:12px;color:var(--c-muted)">たくさんのご応募ありがとうございました。</p>
          {if isset($campaign.archive_url) && $campaign.archive_url != ''}
            <p style="margin-top:16px"><a class="cta cta--ghost" href="{$campaign.archive_url|escape}">アーカイブを見る</a></p>
          {/if}
        </div>
      {else}
        <div id="form-messages" role="status" aria-live="polite"></div>
        
        <p style="margin-bottom:20px">以下のフォームに必要事項をご入力ください。</p>
        
        <form id="entry-form" action="{$entry.action|default:'#'|escape}" method="post" novalidate class="card" style="display:grid;gap:16px">
          
          <div class="form-field">
            <label class="form-label" for="entry-name">
              お名前<span class="required-badge">必須</span>
            </label>
            <input type="text" 
                   id="entry-name" 
                   name="name" 
                   required 
                   aria-required="true"
                   aria-describedby="name-error"
                   placeholder="山田 太郎" />
            <div id="name-error" class="error-message" style="display:none" role="alert"></div>
          </div>

          <div class="form-field">
            <label class="form-label" for="entry-email">
              メールアドレス<span class="required-badge">必須</span>
            </label>
            <input type="email" 
                   id="entry-email" 
                   name="email" 
                   required 
                   aria-required="true"
                   aria-describedby="email-error"
                   placeholder="example@email.com" />
            <div id="email-error" class="error-message" style="display:none" role="alert"></div>
          </div>

          {if isset($entry.extra_fields) && $entry.extra_fields|@count > 0}
            {foreach $entry.extra_fields as $ef name=extra}
              <div class="form-field">
                <label class="form-label" for="entry-{$ef.name|escape}">
                  {$ef.label|escape}
                  {if isset($ef.required) && $ef.required}<span class="required-badge">必須</span>{/if}
                </label>
                {if $ef.type == 'select'}
                  <select id="entry-{$ef.name|escape}" 
                          name="{$ef.name|escape}"
                          {if isset($ef.required) && $ef.required}required aria-required="true"{/if}>
                    <option value="">選択してください</option>
                    {foreach $ef.options as $op}
                      <option value="{$op.value|escape}">{$op.label|escape}</option>
                    {/foreach}
                  </select>
                {else}
                  <input type="text" 
                         id="entry-{$ef.name|escape}" 
                         name="{$ef.name|escape}"
                         {if isset($ef.required) && $ef.required}required aria-required="true"{/if}
                         {if isset($ef.placeholder) && $ef.placeholder != ''}placeholder="{$ef.placeholder|escape}"{/if} />
                {/if}
                <div id="{$ef.name|escape}-error" class="error-message" style="display:none" role="alert"></div>
              </div>
            {/foreach}
          {/if}

          <label class="custom-checkbox">
            <input type="checkbox" 
                   id="entry-agree" 
                   name="agree" 
                   value="1" 
                   required 
                   aria-required="true"
                   aria-describedby="agree-error" />
            <span>
              <a href="{$links.terms|default:'#'|escape}" target="_blank" rel="noopener" style="text-decoration:underline">利用規約</a>および<a href="{$links.privacy|default:'#'|escape}" target="_blank" rel="noopener" style="text-decoration:underline">プライバシーポリシー</a>に同意する
            </span>
          </label>
          <div id="agree-error" class="error-message" style="display:none" role="alert"></div>

          <button class="cta" type="submit" id="submit-btn" style="justify-self:start">
            <span id="submit-text">エントリーする</span>
            <span id="submit-spinner" class="spinner" style="display:none"></span>
          </button>
          
          <p class="note">※送信により上記ポリシーに同意したものとみなします。<br>※ご入力いただいた情報は厳重に管理いたします。</p>
        </form>
      {/if}
    </div>
  </section>

  {* FAQ *}
  {if isset($faq) && $faq|@count > 0}
  <section class="section faq" id="faq" aria-labelledby="faq-title">
    <div class="container">
      <h2 id="faq-title">{if isset($sections.faq_title) && $sections.faq_title != ''}{$sections.faq_title|escape}{else}❓ よくある質問{/if}</h2>
      {foreach $faq as $q name=faq}
        <details id="faq-{$smarty.foreach.faq.index}">
          <summary aria-controls="faq-content-{$smarty.foreach.faq.index}" aria-expanded="false">{$q.q|escape}</summary>
          <div id="faq-content-{$smarty.foreach.faq.index}" style="margin-top:12px;line-height:1.7">{$q.a|escape}</div>
        </details>
      {/foreach}
    </div>
  </section>
  {/if}

  {* フローティングCTA（モバイル用） *}
  {if !(isset($campaign.is_ended) && $campaign.is_ended)}
  <div class="floating-cta" id="floating-cta" style="display:none">
    <a class="cta" href="#entry">今すぐエントリー</a>
  </div>
  {/if}

  {* Footer *}
  <footer class="footer" role="contentinfo">
    <div class="container">
      <div style="display:flex;justify-content:space-between;gap:16px;flex-wrap:wrap;align-items:center">
        <div>© {$site.copyright_year|default:'2025'|escape} {$brand.company|default:$brand.name|escape}</div>
        <nav aria-label="フッターナビゲーション" style="display:flex;gap:16px;flex-wrap:wrap">
          {if isset($links.privacy) && $links.privacy != ''}<a href="{$links.privacy|escape}" class="small">プライバシーポリシー</a>{/if}
          {if isset($links.terms) && $links.terms != ''}<a href="{$links.terms|escape}" class="small">利用規約</a>{/if}
          {if isset($links.inquiry) && $links.inquiry != ''}<a href="{$links.inquiry|escape}" class="small">お問い合わせ</a>{/if}
        </nav>
      </div>
    </div>
  </footer>

  {* JSON-LD（FAQ込み） *}
  {capture assign=__jsonld}
  {
    "@context": "https://schema.org",
    "@graph": [
      {
        "@type": "Organization",
        "name": "{$brand.company|default:$brand.name|escape:'javascript'}",
        "url": "{$site.baseUrl|escape:'javascript'}",
        "logo": "{$brand.logo|escape:'javascript'}"
      },
      {
        "@type": "WebPage",
        "name": "{$site.title|escape:'javascript'}",
        "url": "{$site.baseUrl|escape:'javascript'}",
        "description": "{$site.description|escape:'javascript'}",
        "inLanguage": "ja"
      }
      {if isset($faq) && $faq|@count > 0}
      ,{
        "@type": "FAQPage",
        "mainEntity": [
          {foreach $faq as $q name=f}
          {
            "@type": "Question",
            "name": "{$q.q|escape:'javascript'}",
            "acceptedAnswer": {
              "@type": "Answer",
              "text": "{$q.a|escape:'javascript'}"
            }
          }{if not $smarty.foreach.f.last},{/if}
          {/foreach}
        ]
      }
      {/if}
    ]
  }
  {/capture}
  <script type="application/ld+json">{$__jsonld nofilter}</script>

  {* JavaScript *}
  <script>
    (function() {
      'use strict';
      
      // カウントダウンタイマー
      const countdownEl = document.getElementById('countdown');
      if (countdownEl) {
        const endDate = new Date(countdownEl.dataset.endDate);
        
        function updateCountdown() {
          const now = new Date();
          const diff = endDate - now;
          
          if (diff <= 0) {
            countdownEl.innerHTML = '<div class="countdown-item" style="grid-column: 1/-1"><span class="countdown-value">終了</span></div>';
            return;
          }
          
          const days = Math.floor(diff / (1000 * 60 * 60 * 24));
          const hours = Math.floor((diff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
          const minutes = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60));
          const seconds = Math.floor((diff % (1000 * 60)) / 1000);
          
          document.getElementById('days').textContent = String(days).padStart(2, '0');
          document.getElementById('hours').textContent = String(hours).padStart(2, '0');
          document.getElementById('minutes').textContent = String(minutes).padStart(2, '0');
          document.getElementById('seconds').textContent = String(seconds).padStart(2, '0');
        }
        
        updateCountdown();
        setInterval(updateCountdown, 1000);
      }
      
      // フローティングCTAの表示制御
      const floatingCta = document.getElementById('floating-cta');
      const entrySection = document.getElementById('entry');
      
      if (floatingCta && entrySection) {
        window.addEventListener('scroll', function() {
          const entrySectionTop = entrySection.offsetTop;
          const scrollPosition = window.scrollY + window.innerHeight;
          
          if (scrollPosition < entrySectionTop) {
            floatingCta.style.display = 'block';
          } else {
            floatingCta.style.display = 'none';
          }
        });
      }
      
      // フォームバリデーション
      const form = document.getElementById('entry-form');
      if (form) {
        const submitBtn = document.getElementById('submit-btn');
        const submitText = document.getElementById('submit-text');
        const submitSpinner = document.getElementById('submit-spinner');
        const formMessages = document.getElementById('form-messages');
        
        form.addEventListener('submit', function(e) {
          e.preventDefault();
          
          // エラーメッセージをクリア
          document.querySelectorAll('.error-message').forEach(el => {
            el.style.display = 'none';
            el.textContent = '';
          });
          document.querySelectorAll('.form-field').forEach(el => {
            el.classList.remove('error');
          });
          
          let hasError = false;
          
          // 名前のバリデーション
          const nameInput = document.getElementById('entry-name');
          if (!nameInput.value.trim()) {
            showError('name', 'お名前を入力してください');
            hasError = true;
          }
          
          // メールアドレスのバリデーション
          const emailInput = document.getElementById('entry-email');
          const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
          if (!emailInput.value.trim()) {
            showError('email', 'メールアドレスを入力してください');
            hasError = true;
          } else if (!emailRegex.test(emailInput.value)) {
            showError('email', '有効なメールアドレスを入力してください');
            hasError = true;
          }
          
          // 同意チェックボックスのバリデーション
          const agreeInput = document.getElementById('entry-agree');
          if (!agreeInput.checked) {
            showError('agree', '利用規約に同意してください');
            hasError = true;
          }
          
          if (hasError) {
            return;
          }
          
          // ローディング状態
          submitBtn.disabled = true;
          submitText.style.display = 'none';
          submitSpinner.style.display = 'inline-block';
          
          // フォーム送信（実際のエンドポイントに送信）
          const formData = new FormData(form);
          
          fetch(form.action, {
            method: 'POST',
            body: formData
          })
          .then(response => response.json())
          .then(data => {
            if (data.success) {
              formMessages.innerHTML = '<div class="success-message"><span style="font-size:20px">✓</span><span>エントリーが完了しました！ご登録いただいたメールアドレスに確認メールをお送りしました。</span></div>';
              form.reset();
              form.style.display = 'none';
            } else {
              throw new Error(data.message || '送信に失敗しました');
            }
          })
          .catch(error => {
            formMessages.innerHTML = '<div class="error-message">エラーが発生しました：' + error.message + '</div>';
          })
          .finally(() => {
            submitBtn.disabled = false;
            submitText.style.display = 'inline';
            submitSpinner.style.display = 'none';
          });
        });
        
        function showError(fieldName, message) {
          const errorEl = document.getElementById(fieldName + '-error');
          const fieldEl = document.getElementById('entry-' + fieldName);
          
          if (errorEl) {
            errorEl.textContent = message;
            errorEl.style.display = 'block';
          }
          
          if (fieldEl) {
            fieldEl.closest('.form-field, .custom-checkbox').classList.add('error');
            fieldEl.focus();
          }
        }
      }
      
      // FAQのアクセシビリティ改善
      document.querySelectorAll('.faq details').forEach(details => {
        const summary = details.querySelector('summary');
        details.addEventListener('toggle', function() {
          if (summary) {
            summary.setAttribute('aria-expanded', details.open);
          }
        });
      });
    })();
  </script>

{/block}