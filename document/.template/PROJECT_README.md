# ＜システム名称>

## ディレクトリ構成
---

| ディレクトリ・ファイル名          | 内容                             |
| ----                              | ----                             |
| backend                           | バックエンドエンド用ディレクトリ |
| frontend                          | フロントエンド用ディレクトリ     |
| infrastructure                    | インフラ関連ディレクトリ         |
| make                              | makeファイル管理用ディレクトリ   |
| document                          | ドキュメント関連ディレクトリ     |
| .env.sample                       | 環境変数定義ファイルサンプル     |
| .gitignore                        | git追跡除外リスト                | 
| docker-compose-infrastructure.yml | インフラデプロイ用コンテナ定義   | 
| docker-compose.yml                | コンテナ定義                     | 

<br>

## 仕様書
---

### 設計書（Design）
* [詳細設計書（Detail Design）](./document/system_design/detail_design/main.md)

### 画面
* [画面仕様書](#) <!-- TODO: FigmaやPDFなどのリンクに置き換え -->

### API
* [API仕様書](http://localhost:8000/api-docs)

### テスト
### 単体テスト

* [バックエンド](./document/test/unit/backend/rspec.xml)
* [フロントエンド](./document/test/unit/frontend/jest.xml)
* [インフラ](./document/test/unit/infrastructure/infra.xml)

### 結合テスト
* [テストシナリオ](#) <!-- TODO: 実体ができたらリンク化 -->

<br>
<br>

## デプロイ
---

### インフラ構築

* ローカル開発環境の構築
  * [構築手順](./document/deploy/local/main.md)
  
* AWS環境の構築
  * [初期構築手順](./document/deploy/aws_initial/main.md)
  * [デプロイ手順](./document/deploy/aws_subsequent/main.md)

<br>
<br>

## 運用
---

* [運用](./document/operation/operation/main.md)
* [保守](./document/operation/maintenance/main.md)
* [監視](./document/operation/monitoring/main.md)


<br>
<br>

## 開発規則
---

* [開発規則](./document/rules/main.md)