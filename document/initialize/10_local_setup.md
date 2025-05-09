<div align="center">
    <img src="https://github.com/user-attachments/assets/572ac68b-05cb-49db-8eed-2d4ae81a43f5" alt="" width="100%">
</div>

## 目次
---
- [1. 概要](#1.概要)
- [2. 事前準備](#2.事前準備)
- [3. 構築](#3.構築)

<br>
<br>

## 1.概要
---

本項目では、ローカル開発環境を構築するベースとなる、コンテナ環境の展開を実施します。

<br>
<br>

## 2.事前準備
---

### 2.1. 環境変数の定義
プロジェクトルートに.envファイルを配置してください。

.envファイルのサンプルは.env.sampleとして配置しています。Renameするか、コピーして.envを作成してください。
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

### 2.2.必要ソフトウェアのインストール・機能の有効化
Infrastructure構築用のコンテナの立ち上げに必要な下記のソフトウェアを用意してください。

#### 2.2.1.Windows
WindowsはWSL(Ubuntu) + Docker Desktopを利用します。


* [Docker Desktop](https://www.bing.com/search?qs=HS&pq=Docker&sk=CSYN1&sc=13-6&pglt=2083&q=docker+desktop&cvid=02fa67f8ea97404aa3325ef6f3b5e920&gs_lcrp=EgRlZGdlKgcIABAAGPkHMgcIABAAGPkHMgYIARBFGDkyBggCEAAYQDIGCAMQRRg7MgYIBBAAGEAyBggFEAAYQDIGCAYQABhAMgYIBxBFGDwyBggIEEUYPNIBCDEyMzRqMGoxqAIIsAIB&FORM=ANNTA1&PC=U531)のインストール

* [WSL](https://learn.microsoft.com/ja-jp/windows/wsl/install)の有効化
  * Windows11からはWSLをインストールする前提条件として下記のWindowsの機能を有効化する必要があります。
    * Linux 用 Windows サブシステム
    * Hype-V

* [Ubuntu(WSL distribution)]()のインストール

#### 2.2.2.MAC

* [Docker Desktop](https://www.bing.com/search?qs=HS&pq=Docker&sk=CSYN1&sc=13-6&pglt=2083&q=docker+desktop&cvid=02fa67f8ea97404aa3325ef6f3b5e920&gs_lcrp=EgRlZGdlKgcIABAAGPkHMgcIABAAGPkHMgYIARBFGDkyBggCEAAYQDIGCAMQRRg7MgYIBBAAGEAyBggFEAAYQDIGCAYQABhAMgYIBxBFGDwyBggIEEUYPNIBCDEyMzRqMGoxqAIIsAIB&FORM=ANNTA1&PC=U531)のインストール
  
<br>
<br>

## 3.ローカル開発環境の構築
---

### 3.1.コンテナの起動

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

<br>
<br>

[PREVIOUS](./03_system_architecture.md)

[NEXT](./11_frontend_setup.md) 

[RETURN README](../../README.md)