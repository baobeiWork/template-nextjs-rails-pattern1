<div align="center">
    <img src="https://github.com/user-attachments/assets/d05a90f4-255a-4e8a-ba76-1cc45194662d" alt="" width="100%">
</div>

## 目次
- [1. 概要](#1.概要)
- [2. frontendコンテナの設定](#2.frontendコンテナの設定)
- [3. frontendコンテナの起動テスト](#2.frontendコンテナの起動テスト)

<br>
<br>

## 1.概要

<br>
<br>

## 2.frontendコンテナの設定
---

### 1.1.初期化

1. Next.js初期化

	下記のコマンドを実行します。fe-initは App Roter推奨ディレクトリの内容でNext.js / Typescript環境を展開します。
	```bash
	make fe-init
	```
	<br>

2. entrypoint.shの切り替え

	下記のコマンドを実行します。初期のentrypoint.shはyarn install 前に起動保持するようになっているため、Webサーバが起動していない状態です。

	切り替えたentrypoint.shを利用することにより、コンテナは再起動するたびにPackage.jsonに基づいてパッケージを更新し、nextが起動するようになります。

	```bash 
	make fe-update type=deploy
	```
	<br>

3. 再起動

	下記のコマンドを実行してフロントエンドコンテナを再起動します。

	```bash 
	make fe-restart
	```
<br>
<br>

## 3.frontendコンテナの起動テスト
---

### 3.1.Next.jsの起動確認

1. ブラウザから下記のURLにアクセスしてください。
   
	```bash 
	http://localhost:8000/
	```

2. 正常にIndexページが表示されることを確認してください。

<br>
<br>

[PREVIOUS](./10_local_setup.md)

[NEXT](./12_backend_setup.md) 

[RETURN README](../../README.md)