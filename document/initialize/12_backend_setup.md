<div align="center">
    <img src="https://github.com/user-attachments/assets/e463269e-e4fb-4324-bcc9-80619a2f8a3e" alt="" width="100%">
</div>

## 目次
---
- [1. 概要](#1.概要)
- [2. backendコンテナの設定](#2.backendコンテナの設定)
- [3. backendコンテナの起動テスト](#2.backendコンテナの起動テスト)

<br>
<br>

## 1.概要
---
本項目では、[ローカル開発環境のセットアップ](./10_local_setup.md)で構築したバックエンドコンテナに対して、RailsのAPIモードを起動し、DBとの接続、Master.keyの発行、コンテナ起動時のentrypointの切り替えを行います。

<br>
<br>

## 2.backendコンテナの設定
---

### 2.1.初期化

1. Railsの初期化

	下記のコマンドを実行します。be-initは APIモードでのRails newの実行および生成された不要ファイルの削除を実行します。

	```bash
	make be-init
	```
	<br>

2. database.ymlの更新
	前項でbe-initにより生成されたファイルにおいて、db接続情報を記載してあげる必要があります。

	「backend/config/database.yml」の「default」項目を次のように修正してください。

	* before

	```yml
	default: &default
		adapter: mysql2
		encoding: utf8mb4
		pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
		username: root
		password:
		host: <%= ENV.fetch("DB_HOST") { "127.0.0.1" } %>
	```

	* after

	```yml
	default: &default
		adapter: mysql2
		encoding: utf8mb4
		pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
		username: root
		password: <%= ENV["DATABASE_PASSWORD"] %>               # データベースパスワードを追記
		host: <%= ENV.fetch("DATABASE_HOST") { "127.0.0.1" } %> # DB_HOST -> DATABASE_PASSWORDへ
	```

	<br>

3. entrypoint.shの切り替え

	下記のコマンドを実行します。初期のentrypoint.shはgem install前に起動保持するようになっているため、Webサーバが起動していない状態です。

	切り替えたentrypoint.shを利用することにより、コンテナは再起動するたびにGemfileに基づいてGemを更新し、Pumaが起動するようになります。

	```bash 
	make be-update-entrypoint type=deploy
	```

	<br>

4. 再起動

	下記のコマンドを実行してフロントエンドコンテナを再起動します。

	```bash 
	make be-restart
	```
<br>
<br>

## 3.backendコンテナの起動テスト
---

### 3.1.Pumaの起動確認

1. ブラウザから下記のURLにアクセスしてください。
   
	```bash 
	http://localhost:3000/
	```

2. 正常にIndexページが表示されることを確認してください。

<img src="./img/12/rails.png" alt="" width="auto">

<br>
<br>

[PREVIOUS](./11_frontend_setup.md)

[NEXT](./20_test_guaid.md) 

[RETURN README](../../README.md)