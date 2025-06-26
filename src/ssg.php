<?php
require_once __DIR__ . '/../vendor/autoload.php';

$smarty = new Smarty\Smarty();
$smarty->setTemplateDir(__DIR__ . '/../templates');
$smarty->setCompileDir(__DIR__ . '/../templates_c');

$dataFile = __DIR__ . '/../data/pages.json';
$pages = json_decode(file_get_contents($dataFile), true);

// CSSコピー処理
$srcCss = __DIR__ . '/../assets/css/style.css';
$destCssDir = __DIR__ . '/../public/css/';

foreach ($pages as $page) {
    $smarty->assign([
        'title' => $page['title'],
        'description' => $page['description']
    ]);

    $output = $smarty->fetch('pages/' . $page['template']);
    file_put_contents(__DIR__ . '/../public/' . $page['filename'], $output);

    echo "生成完了: {$page['filename']}\n";
}

if (!is_dir($destCssDir)) {
    mkdir($destCssDir, 0777, true);
}

copy($srcCss, $destCssDir . 'style.css');
echo "CSSコピー完了: public/css/style.css\n";