<!doctype html>
<html lang="ja">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />

  <title>{block name="title"}{if isset($site.title) && $site.title != ''}{$site.title|escape}{else}Site{/if}{/block}</title>
  <meta name="description" content="{block name="meta_description"}{if isset($site.description) && $site.description != ''}{$site.description|escape}{else}{/if}{/block}" />

  {if isset($site.ogp_image) && $site.ogp_image != ''}
    <meta property="og:type" content="website" />
    <meta property="og:image" content="{$site.ogp_image|escape}" />
  {/if}

  {*
    ページ固有でCSSやpreload、追加meta等を挿入したいときは
    pages/*.tpl 側の {block name="head_append"} ... {/block} で上書き
  *}
  {block name="head_append"}{/block}
</head>
<body class="{$body_class|default:''|escape}">
  {*
    ここにグローバルヘッダー/フッターを置く場合はこのレイアウトに実装し、
    ページ側は主に {block name="content"} を差し込むだけにします。
    今回はページ側でヘッダーを描画しているため何も置いていません。
  *}

  {block name="content"}{/block}

  {*
    必要なら body 終端用の差し込みブロックも用意できます（任意）
    {block name="body_end"}{/block}
  *}
</body>
</html>
