<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>{$title|escape}</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<header>
    <h1>企業サイト</h1>
    <nav>
        <a href="index.html">ホーム</a>
        <a href="about.html">会社概要</a>
        <a href="contact.html">お問い合わせ</a>
    </nav>
</header>

<main>
    {block name="content"}{/block}
</main>

<footer>
    &copy; 2025 企業サイト All rights reserved.
</footer>

</body>
</html>
