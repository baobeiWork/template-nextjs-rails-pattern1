<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>template-nextjs-rails-pattern1</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.9.4/css/bulma.min.css">
  <style>
    html, body {
      height: 100%;
      margin: 0;
      font-family: 'Helvetica Neue', sans-serif;
      background-image: url('./document/.template/readme/assets/img/background_main.png');
      background-size: cover;
      background-position: center;
      background-repeat: no-repeat;
      color: #fff;
    }

    .overlay-box {
      background: rgba(0, 0, 0, 0.6);
      border-radius: 16px;
      padding: 2rem;
      margin: 2rem auto;
      max-width: 800px;
      backdrop-filter: blur(4px);
    }

    .section-title {
      font-size: 1.2rem;
      font-weight: bold;
      text-transform: uppercase;
      color: #f5f5f5;
      border-bottom: 1px solid #ccc;
      margin-bottom: 1rem;
    }

    h1 {
      text-align: center;
      font-size: 2.5rem;
      margin-top: 2rem;
      text-shadow: 1px 1px 2px #000;
    }

    ul {
      margin-left: 1rem;
      list-style-type: disc;
    }
  </style>
</head>
<body>
  <h1>template-nextjs-rails-pattern1</h1>

  <div class="overlay-box">
    <div class="section-title">About Project</div>
    <p>
      このリポジトリテンプレートはRuby On Rails - Next.jsアーキテクチャパターンを簡単にセットアップできる目的でつくられています。<br>
      アーキテクチャ構造だけでなく、
    </p>
    <ul>
      <li>設計ドキュメント</li>
      <li>本番運用を想定したAWS環境構築</li>
      <li>テスト</li>
    </ul>
    <p>などをサポートできるよう構成されています。</p>
  </div>

  <div class="overlay-box">
    <div class="section-title">Stack</div>
    <p>
      Ruby On Rails / Next.js / AWS / Terraform / Docker / GitHub Actions などが採用されています。
    </p>
  </div>

  <div class="overlay-box">
    <div class="section-title">Manual</div>
    <p>
      詳細な構築・デプロイ手順、利用方法などは <code>document/</code> ディレクトリ配下をご確認ください。
    </p>
  </div>
</body>
</html>
