<?php
declare(strict_types=1);

require __DIR__ . '/../vendor/autoload.php';

use Smarty\Smarty; // ← v5 は名前空間付き

$root = realpath(__DIR__ . '/..');
$tplDir = $root . '/templates';
$compileDir = $root . '/templates_c';
$dataFile = $root . '/data/site.json';
$outFile = $root . '/public/index.html';

// --- ロード & 準備 ---
$smarty = new Smarty();
$smarty->setTemplateDir($tplDir);
$smarty->setCompileDir($compileDir);
// デリミタ（必要なら）
$smarty->setLeftDelimiter('{');
$smarty->setRightDelimiter('}');
// 既存テンプレで |escape を多用しているなら、自動エスケープは無効のまま推奨
// $smarty->setEscapeHtml(false);

// --- JSON 読み込み ---
if (!file_exists($dataFile)) {
  fwrite(STDERR, "[ERROR] data JSON not found: {$dataFile}\n");
  exit(1);
}
$json = file_get_contents($dataFile);
$data = json_decode($json, true, 512, JSON_THROW_ON_ERROR);

// --- 変数割り当て ---
foreach ($data as $k => $v) {
  $smarty->assign($k, $v);
}

// --- レンダリング ---
$html = $smarty->fetch('pages/index.tpl');

// --- 出力 ---
if (false === file_put_contents($outFile, $html)) {
  fwrite(STDERR, "[ERROR] failed to write: {$outFile}\n");
  exit(1);
}
echo "[OK] built: {$outFile}\n";
