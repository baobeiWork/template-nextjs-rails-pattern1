# ローカル開発環境：初期構築

## 事前準備
---

### 必要ソフトウェアの導入

1.  下記のソフトウェア・ツールをインストールしてください

   | Name           | Link | Remarks |
   | :---           | :--- | :---    | 
   | Docker Desktop | https://www.docker.com/ja-jp/products/docker-desktop/ | 

### .envファイルの準備

* プロジェクトルートにある.env.sampleを参考に、.envファイルを作成してください。各環変数の内容は下記の通りです。

	| 環境変数名 						  	| 適用されるコンテナ 	| 説明 | 
	| :---       						  	| :--- 				 	 			| :--- | 
	| SYSTEM_NAME						  	| all 								| システム名
	| SYSTEM_DOMAIN 				  	| all 								| システムドメイン名
	| NEXT_ENV							  	| frontend 						| 起動したい環境名
	| NEXT_PUBLIC_API_URL 			| frontend 						| backendのエンドポイント
	| NEXT_PUBLIC_IS_API_MOCKED | frontend 						| Mock Serverを利用するか（true / false）
	| MYSQL_ROOT_USER					  | db									| ローカルで起動する mysql root名
	| MYSQL_ROOT_PASSWORD 			| db									| ローカルで起動する mysql rootパスワード
	| MYSQL_USERNAME					  | db									| ローカルで起動する mysql ユーザー名
	| MYSQL_PASSWORD					  | db									| ローカルで起動する mysql パスワード
	| MYSQL_DATABASE					  | db									| ローカルで起動する mysql データベース名

<br>
<br>

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

1. Rails New の実行

	下記のコマンドを実行します。init-beは APIモードでのRails newの実行および生成された不要ファイルの削除を実行します。

	```bash
	make be-init
	```

### Frontendコンテナの設定

#### 初期化

1. Rails New の実行

	下記のコマンドを実行します。init-beは APIモードでのRails newの実行および生成された不要ファイルの削除を実行します。

	```bash
	make fe-init
	```



	<br>

### テスト
#### コンテナが正常に起動するかの確認

1. 下記のコマンドを実行します。

	```bash
	docker ps -a  
	```

2. 下記のように、「assetcompass_frontend」、「assetcompass_backend」、「assetcompass_db」コンテナがそれぞれ起動していることを確認してください

	```bash
	 parallels@ubuntu-linux-20-04-desktop:/media/psf/AssetCompass$ sudo docker ps -a  
	[sudo] parallels のパスワード: 
	CONTAINER ID   IMAGE                   COMMAND                  CREATED          STATUS          PORTS                                                  NAMES
	abeec4430517   assetcompass_frontend   "entrypoint.sh"          55 minutes ago   Up 49 minutes   0.0.0.0:8000->8000/tcp, :::8000->8000/tcp              assetcompass_frontend_1
	4dd3365aa2c8   assetcompass_backend    "entrypoint.sh"          55 minutes ago   Up 45 minutes   0.0.0.0:3000->3000/tcp, :::3000->3000/tcp              assetcompass_backend_1
	668b024999a4   mysql:8.4               "docker-entrypoint.s…"   15 hours ago     Up 2 hours      0.0.0.0:3306->3306/tcp, :::3306->3306/tcp, 33060/tcp   assetcompass_db_1
	```

	<br>

#### フロントエンドの起動確認

1. ブラウザから下記のURLにアクセスしてください。
   
	```bash 
	http://localhost:8000/
	```

2. 正常にNindexページが表示されることを確認してください。


#### バックエンドの起動確認

1. ブラウザから下記のURLにアクセスしてください。
   
	```bash 
	http://localhost:3000/local_deployment_verifications
	```

2. 下記の表示が確認できることを確認してください。

	```bash 
	{"message":"Local deployment api verification successful!"}
	``` 

#### フロントエンドからバックエンドの通信確認

1. 下記のコマンドを実行し、フロントエンドのコンテナにログインしす。

   ```bash 
   sudo docker exec -it <FrontEnd CONTAINER ID> /bin/bash
   ```

2. コンテナログイン後、下記のコマンドを実行します。

   ```bash 
   curl http://backend:3000/local_deployment_verifications
   ```

3. 下記の表示が確認できることを確認してください。

	```bash 
	{"message":"Local deployment api verification successful!"}
	``` 
<br>


[READMEトップに戻る](../../../../../README.md)