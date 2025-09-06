# my-ssg-site
このリポジトリは、Smarty（PHPテンプレートエンジン）を用いた **SSG（静的サイトジェネレーター）** のテスト実装です。  
主にHTMLテンプレートを元に、PHPで静的なHTMLファイルを自動生成する構成になっています。


# 静的サイトジェネレータ（SSG） - Smarty × PHP版

本プロジェクトは、PHPテンプレートエンジン「Smarty」と独自PHPスクリプトを用いた静的HTML生成（SSG）のサンプルです。

---

## 📦 インフラ・前提環境

- **XAMPP（推奨）**
    - PHP 8.x以上
    - Composer同梱 または別途インストール
    - Windows環境推奨（他OSでも動作可）

XAMPPのダウンロード：
[https://www.apachefriends.org/index.html](https://www.apachefriends.org/index.html)

---

## 🚀 セットアップ手順

1. `htdocs` 配下に本プロジェクト配置例：

    ```
    C:\xampp\htdocs\my-ssg-site
    ```

2. ターミナル（コマンドプロンプト）で以下を実行：

    ```bash
    cd C:\xampp\htdocs\my-ssg-site
    composer install
    ```

3. 必要に応じてテンプレート・デザインを編集

---

## ⚙️ ビルド方法

```bash
php build.php
