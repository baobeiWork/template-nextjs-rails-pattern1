# AWS環境構築（2回目以降）手順書
## 概要
このドキュメントはAWSに対する、環境ごとの初回のインフラ構築手順を示します。  

## ワークフロー
環境構築は以下のワークフローにて実施します。

  1. 事前準備 
  2. 各種更新

  <br>
  <br>

## 1. 事前準備
###  1.1. インフラ構築用コンテナの起動
* この項目では、以降の作業をするにあたって、必要となるインフラ構築用のdockerコンテナを起動します。
* 前提として、[AWS環境構築（初回）手順書](../deployment_guide_aws_initial/main.md)の「2. インフラ構築用コンテナの起動」が完了しているものとします。

1. コンテナセットの起動
  
    プロジェクトルートにて、下記のコマンドを実行し、実行環境を起動させます。

    ```bash
    # -d オプションはバックグラウンド実行
    docker-compose -f docker-compose-infrastructure.yml up -d 
    ```
    
    infrastructureコンテナが起動できていることを確認します。

    ```bash 
    # コンテナを確認
    sudo docker ps -a

    # 下記のように「assetcompass_infrastructure」のSTATUSがUPであること
    parallels@ubuntu-linux-20-04-desktop:/media/psf/AssetCompass$ sudo docker ps -a 
    CONTAINER ID   IMAGE                         COMMAND                  CREATED              STATUS                      PORTS     NAMES
    74b6a7da15af   assetcompass_infrastructure   "/usr/bin/entrypoint…"   About a minute ago   Up About a minute                     assetcompass_infrastructure_1
    ```

    <br>
    <br>

### 1.2. インフラ構築環境へのログイン
この項目では、前項で構築したインフラ実行環境へログインし、構築したい環境情報（production / stagin / test）に応じた環境変数を設定します。

1. ログイン

    プロジェクトルートより、下記のコマンドを実行しインフラ実行環境へログインしてください。

    ```bash 
    docker exec -it assetcompass_infrastructure_1 /bin/bash
    ```

### 1.3. 環境変数の設定

1. システム環境変数の設定
  
   次のシェルを実行し、システム環境変数を設定します。環境名称にはproduction / staging / testのいずれかを入力してください。

    ```bash
    source /usr/bin/set_env.sh <環境名称>
    ```
    
    <br>
    <br>


## 2. 各種更新

## 2.1. インフラの更新

### 2.1.1. Terraformの更新


1. カレントディレクトリの移動

    以下のコマンドを実行し、Terraform実行ディレクトリへ移動します。

   ```bash
   cd $INFRASTRUCTURE_HOME/terraform/environments/$SYSTEM_ENV/
   ```

2. Terraform initの実行（モジュールを追加した場合は実行。必要に応じて）

    以下のコマンドを実行し、Terraformの初期化を実行してください。

    ```bash 
    terraform init \
    -backend-config="bucket=${BUCKET_NAME}" \
    -backend-config="key=terraform.tfstate" \
    -backend-config="region=${SYSTEM_REGION}" \
    -backend-config="encrypt=false" \
    -backend-config="dynamodb_table=${LOCK_TABLE}"

    ```

    <br>

3. メインコンポーネントのApply

   前項でSecretが登録されたので、メインコンポーネントをApplyします。次のコマンドを実行してください。

   ```bash 
   # Plan 
   terraform plan

   # Apply 
   terraform apply
   ```

   <br>

### 2.2. バックエンドコンテナの更新

#### 2.2.1. イメージの作成とECRプッシュ

1. カレントディレクトリの移動

    以下のコマンドを実行し、Terraform実行ディレクトリへ移動します。

   ```bash
   cd /asset_compass
   ```

2. イメージの作成とECRプッシュ
  
   次のシェルを実行し、Cloud Formationで作成したECRにイメージをプッシュします。
   環境名称にはproduction / staging / testのいずれかを入力してください。

    ```bash
    /usr/bin/image_push.sh
    ```
    
    <br>
    <br>

#### 2.2.2. ECSタスクの更新

1. 下記のコマンドを実行し、ECSタスク定義を更新（先程PUSHしたイメージをPULLするように）します。

    ```bash 
    /usr/bin/ecs_deploy.sh
    ```

2. AWSにログイン後、Amazon Elastic Container Service > クラスター > asset-compass-production-main-cluster > サービス > 
asset-compass-production-service を確認し、「デプロイのステータス」が「成功」になることを確認します。


### 2.3. フロントエンドのビルド・アップロード
* 本項目では、フロントエンドのコードのビルド・S3へのアップロードを実行します。

#### 2.3.1. フロントエンドのビルド
この手順はコンテナホスト上で実施します。

1. yarn generateの実行

	下記のコマンドを実行し、フロントエンドのnuxtプロジェクトをビルドします。

	```bash 
	docker exec -it assetcompass_frontend_1 yarn generate
	```


### 2.3.2. ビルドコンテンツのアップロード

1. ログイン

    プロジェクトルートより、下記のコマンドを実行しインフラ実行環境へログインしてください。

    ```bash 
    docker exec -it assetcompass_infrastructure_1 /bin/bash
    ```

2. ビルドコンテンツのアップロード
  
   インフラ実行環境で下記のコマンドを実行し、ビルドコンテンツをアップロードします。

    ```bash
    aws s3 sync /asset_compass/FrontEnd/.output/public s3://asset-compass-production-web-host --delete
    ```


[READMEトップに戻る](../../../../../README.md)
