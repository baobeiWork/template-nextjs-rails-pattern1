<div align="center">
    <img src="https://github.com/user-attachments/assets/572ac68b-05cb-49db-8eed-2d4ae81a43f5" alt="" width="100%">
</div>

## 目次
- [1. 事前準備](#1-事前準備)
- [2. 構築](#構築)
- [3. Backend コンテナの設定](#backendコンテナの設定)
- [4. Frontend コンテナの設定](#frontendコンテナの設定)
- [5. テスト](#テスト)


## 1. 事前準備
---

### 1.1. 環境変数の定義
プロジェクトルートに.envファイルを配置してください。

.envファイルのサンプルは.env.sampleとして配置しています。Renameするか、コピーして.evvを作成してください。
* 環境変数

	| 環境変数名 								| 適用されるコンテナ 	| 説明
	| :---       								| :--- 				 	 			| :---
	| LOCAL_ARCH 								| all									| ローカル開発環境を立ち上げるコンピュータのアーキテクチャ（amd64 / arm64 ）
	| SYSTEM_NAME								| all 								| システム名
	| SYSTEM_DOMAIN 						| all 								| システムドメイン名
	| NEXT_ENV									| frontend 						| 起動したい環境名
	| NEXT_PUBLIC_API_URL 			| frontend 						| backendのエンドポイント
	| NEXT_PUBLIC_IS_API_MOCKED | frontend 						| Mock Serverを利用するか（true / false）
	| MYSQL_ROOT_USER						| db									| ローカルで起動する mysql root名
	| MYSQL_ROOT_PASSWORD 			| db									| ローカルで起動する mysql rootパスワード
	| MYSQL_USERNAME					  | db									| ローカルで起動する mysql ユーザー名
	| MYSQL_PASSWORD					  | db									| ローカルで起動する mysql パスワード
	| MYSQL_DATABASE					  | db									| ローカルで起動する mysql データベース名

<br>

### 1.2. 必要ソフトウェアのインストール・機能の有効化
Infrastructure構築用のコンテナの立ち上げに必要な下記のソフトウェアを用意してください。

#### 1.2.1. Windows
WindowsはWSL(Ubuntu) + Docker Desktopを利用します。


* [Docker Desktop](https://www.bing.com/search?qs=HS&pq=Docker&sk=CSYN1&sc=13-6&pglt=2083&q=docker+desktop&cvid=02fa67f8ea97404aa3325ef6f3b5e920&gs_lcrp=EgRlZGdlKgcIABAAGPkHMgcIABAAGPkHMgYIARBFGDkyBggCEAAYQDIGCAMQRRg7MgYIBBAAGEAyBggFEAAYQDIGCAYQABhAMgYIBxBFGDwyBggIEEUYPNIBCDEyMzRqMGoxqAIIsAIB&FORM=ANNTA1&PC=U531)のインストール

* [WSL](https://learn.microsoft.com/ja-jp/windows/wsl/install)の有効化
  * Windows11からはWSLをインストールする前提条件として下記のWindowsの機能を有効化する必要があります。
    * Linux 用 Windows サブシステム
    * Hype-V

* [Ubuntu(WSL distribution)]()のインストール

#### 1.2.2. MAC

* [Docker Desktop](https://www.bing.com/search?qs=HS&pq=Docker&sk=CSYN1&sc=13-6&pglt=2083&q=docker+desktop&cvid=02fa67f8ea97404aa3325ef6f3b5e920&gs_lcrp=EgRlZGdlKgcIABAAGPkHMgcIABAAGPkHMgYIARBFGDkyBggCEAAYQDIGCAMQRRg7MgYIBBAAGEAyBggFEAAYQDIGCAYQABhAMgYIBxBFGDwyBggIEEUYPNIBCDEyMzRqMGoxqAIIsAIB&FORM=ANNTA1&PC=U531)のインストール


#### 1.3. master.keyの配置

   BackEnd/config/にmaster.keyを配置してください。

	 master.keyは下記の共有フォルダに格納しています。

	 * [AssetCompass/infrastructure/01_ローカル開発環境](https://drive.google.com/drive/folders/16F5p7X0yepL_9PuN82hPS9EU14tqNZIG?usp=drive_link)

  

## 構築
---

### コンテナの起動

1. コンテナイメージのビルドの実行

	下記のコマンドを実行します

	```bash
	make build
	```

2. コンテナの起動

	下記のコマンドを実行します

	```bash
	make up 
	```

3. 確認

	下記のコマンドを実行します。

	```bash
	make show  
	```

### Backendコンテナの設定

#### 初期化

1. Railsの初期化

	下記のコマンドを実行します。be-initは APIモードでのRails newの実行および生成された不要ファイルの削除を実行します。

	```bash
	make be-init
	```

### Frontendコンテナの設定

#### 初期化

1. Next.js初期化

	下記のコマンドを実行します。fe-initは App Roter推奨ディレクトリの内容でNext.js / Typescript環境を展開します。
	```bash
	make fe-init
	```
	<br>

### テスト

#### フロントエンドの起動確認

1. ブラウザから下記のURLにアクセスしてください。
   
	```bash 
	http://localhost:8000/
	```

2. 正常にIndexページが表示されることを確認してください。


#### バックエンドの起動確認

1. ブラウザから下記のURLにアクセスしてください。
   
	```bash 
	http://localhost:3000/local_deployment_verifications
	```

2. 下記の表示が確認できることを確認してください。

	```bash 
	{"message":"Local deployment api verification successful!"}
	``` 

[次のステップへ](../)

[READMEトップに戻る](../../README.md)