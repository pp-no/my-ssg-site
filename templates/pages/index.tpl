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
          <img src="{$brand.logo|escape}" alt="{$brand.name|escape}" />
        {/if}
        <span>{$brand.name|escape}</span>
        {if isset($campaign.is_ended) && $campaign.is_ended}
          <span class="label label--end">ENDED</span>
        {elseif isset($campaign.is_new) && $campaign.is_new}
          <span class="label label--new">NEW</span>
        {/if}
      </a>

      <nav>
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
  <section class="hero" aria-label="キービジュアル">
    <div class="container hero-inner">
      <div>
        <h1>
          {if isset($hero.title) && $hero.title != ''}{$hero.title|escape}{else}FASHION HOLIDAY CAMPAIGN{/if}
        </h1>
        {if isset($hero.subtitle) && $hero.subtitle != ''}
          <p class="sub">{$hero.subtitle|escape}</p>
        {/if}

        {if isset($campaign.is_ended) && $campaign.is_ended}
          <div class="card" role="note" style="margin-top:12px">
            <strong>キャンペーンは終了しました。</strong><br />
            {if isset($campaign.ended_message) && $campaign.ended_message != ''}{$campaign.ended_message|escape}{/if}
          </div>
        {else}
          {if isset($campaign.copy) && $campaign.copy != ''}
            <p class="sub"><strong>{$campaign.copy|escape}</strong></p>
          {/if}
          {if isset($campaign.period) && $campaign.period != ''}
            <ul class="note" aria-label="キャンペーン概要">
              <li>実施期間：{$campaign.period|escape}</li>
            </ul>
          {/if}
          <p style="margin-top:16px">
            <a class="cta" href="#entry">エントリーして特典を受け取る</a>
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
  <section class="section" id="features" aria-label="特長">
    <div class="container">
      <h2>{if isset($sections.features_title) && $sections.features_title != ''}{$sections.features_title|escape}{else}選ばれる理由{/if}</h2>
      <div class="grid-3">
        {foreach $features as $f}
          <article class="card">
            <h3>{$f.title|escape}</h3>
            {if isset($f.text) && $f.text != ''}<p>{$f.text|escape}</p>{/if}
          </article>
        {/foreach}
      </div>
    </div>
  </section>
  {/if}

  {* Campaign detail *}
  <section class="section" id="campaign" aria-label="キャンペーン詳細">
    <div class="container">
      <h2>{if isset($sections.detail_title) && $sections.detail_title != ''}{$sections.detail_title|escape}{else}キャンペーン詳細{/if}</h2>
      <div class="details" role="region" aria-labelledby="campaign">
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
      {if isset($campaign.note) && $campaign.note != ''}<p class="note" style="margin-top:10px">{$campaign.note|escape}</p>{/if}
    </div>
  </section>

  {* Entry（終了時は非表示 or メッセージ差替え） *}
  <section class="section" id="entry" aria-label="エントリー">
    <div class="container">
      <h2>今すぐエントリー</h2>

      {if isset($campaign.is_ended) && $campaign.is_ended}
        <div class="card">
          <p>本キャンペーンのエントリー受付は終了しました。</p>
          {if isset($campaign.archive_url) && $campaign.archive_url != ''}
            <p style="margin-top:8px"><a class="cta cta--ghost" href="{$campaign.archive_url|escape}">アーカイブを見る</a></p>
          {/if}
        </div>
      {else}
        <p>以下のフォームに必要事項をご入力ください。</p>
        <form action="{$entry.action|default:'#'|escape}" method="post" novalidate class="card" style="display:grid;gap:12px">
          <label>
            <span>お名前（必須）</span><br />
            <input type="text" name="name" required aria-required="true" style="width:100%;padding:12px;border:1px solid var(--c-border);border-radius:10px" />
          </label>
          <label>
            <span>メールアドレス（必須）</span><br />
            <input type="email" name="email" required aria-required="true" style="width:100%;padding:12px;border:1px solid var(--c-border);border-radius:10px" />
          </label>

          {if isset($entry.extra_fields) && $entry.extra_fields|@count > 0}
            {foreach $entry.extra_fields as $ef}
              <label>
                <span>{$ef.label|escape}</span><br />
                {if $ef.type == 'select'}
                  <select name="{$ef.name|escape}" style="width:100%;padding:12px;border:1px solid var(--c-border);border-radius:10px">
                    <option value="">選択してください</option>
                    {foreach $ef.options as $op}
                      <option value="{$op.value|escape}">{$op.label|escape}</option>
                    {/foreach}
                  </select>
                {else}
                  <input type="text" name="{$ef.name|escape}" style="width:100%;padding:12px;border:1px solid var(--c-border);border-radius:10px" />
                {/if}
              </label>
            {/foreach}
          {/if}

          <label style="display:flex;gap:8px;align-items:center">
            <input type="checkbox" name="agree" value="1" required aria-required="true" />
            <span>利用規約に同意する</span>
          </label>
          <button class="cta" type="submit" style="justify-self:start">エントリーする</button>
          <p class="note">※送信によりプライバシーポリシーに同意したものとみなします。</p>
        </form>
      {/if}
    </div>
  </section>

  {* FAQ *}
  {if isset($faq) && $faq|@count > 0}
  <section class="section faq" id="faq" aria-label="よくある質問">
    <div class="container">
      <h2>{if isset($sections.faq_title) && $sections.faq_title != ''}{$sections.faq_title|escape}{else}よくある質問{/if}</h2>
      {foreach $faq as $q}
        <details>
          <summary>{$q.q|escape}</summary>
          <div style="margin-top:8px">{$q.a|escape}</div>
        </details>
      {/foreach}
    </div>
  </section>
  {/if}

  {* Footer *}
  <footer class="footer" role="contentinfo">
    <div class="container">
      <div style="display:flex;justify-content:space-between;gap:16px;flex-wrap:wrap;align-items:center">
        <div>© {$site.copyright_year|default:'2025'|escape} {$brand.company|default:$brand.name|escape}</div>
        <nav style="display:flex;gap:16px">
          {if isset($links.privacy) && $links.privacy != ''}<a href="{$links.privacy|escape}" class="small">プライバシーポリシー</a>{/if}
          {if isset($links.terms) && $links.terms != ''}<a href="{$links.terms|escape}" class="small">利用規約</a>{/if}
          {if isset($links.inquiry) && $links.inquiry != ''}<a href="{$links.inquiry|escape}" class="small">お問い合わせ</a>{/if}
        </nav>
      </div>
    </div>
  </footer>

  {* JSON-LD（FAQ込み）。site.json 側で raw を持たせたくない場合ここで生成 *}
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

{/block}
