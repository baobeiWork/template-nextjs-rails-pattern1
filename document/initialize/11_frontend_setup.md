<div align="center">
    <img src="https://github.com/user-attachments/assets/d05a90f4-255a-4e8a-ba76-1cc45194662d" alt="" width="100%">
</div>

## 4.frontendコンテナの設定
---

### 4.1.初期化

1. Next.js初期化

	下記のコマンドを実行します。fe-initは App Roter推奨ディレクトリの内容でNext.js / Typescript環境を展開します。
	```bash
	make fe-init
	```
	<br>

2. entrypoint.shの切り替え

	下記のコマンドを実行します。初期のentrypoint.shはyarn install 前に起動保持するようになっているため、Webサーバが起動していない状態です。

	切り替えたentrypoint.shを利用することにより、コンテナは再起動するたびにパッケージを更新し、nextが起動するようになります。

	```bash 
	sudo make fe-update type=deploy
	```
	<br>

3. 再起動

	下記のコマンドを実行してフロントエンドコンテナを再起動します。

	```bash 
	```
<br>
<br>

## 6.テスト
---

### フロントエンドの起動確認

1. ブラウザから下記のURLにアクセスしてください。
   
	```bash 
	http://localhost:8000/
	```

2. 正常にIndexページが表示されることを確認してください。





[PREVIOUS](./10_local_setup.md)

[NEXT](./12_backend_setup.md) 

[RETURN README](../../README.md)