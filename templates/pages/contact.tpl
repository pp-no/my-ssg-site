{extends file="layouts/default.tpl"}

{block name="content"}
    <h2>{$title}</h2>
    <p>{$description}</p>

    <form action="mailto:info@example.com" method="post">
        <label>お名前：</label><br>
        <input type="text" name="name"><br><br>

        <label>メールアドレス：</label><br>
        <input type="email" name="email"><br><br>

        <label>お問い合わせ内容：</label><br>
        <textarea name="message" rows="5"></textarea><br><br>

        <button type="submit">送信</button>
    </form>
{/block}
