<div align="center">
    <img src="https://github.com/user-attachments/assets/c23f6aff-e1cf-41d9-ba73-100528b39622" alt="" width="100%">
</div>

## 目次
---
- [1. 概要](#1.概要)
- [2. frontendコンテナの設定](#2.frontendコンテナの設定)
- [3. backendコンテナの設定](#3.backendコンテナの設定)
- [4. swaggerの設定](#4.swaggerの設定)
- [5. 動作テスト](#5動作テスト) 

<br>
<br>

## 1.概要
---
本項目では、[ローカル開発環境のセットアップ](./10_local_setup.md) ~ [フロントエンドの設定](./11_frontend_setup.md) / [バックエンドの設定](./12_backend_setup.md)において、構築したコンテナに対してswaggerとSpec / Jestを連携するように設定します。

Swagger形式で統一・横断的な単体テストドキュメント・テスト内容の管理ができます。

* swagger - spec / jestの参照イメージを後ほど追加

<br>
<br>

## 2.frontendコンテナの設定
---

### 2.1.構成

| 項目         | 内容                              |
| ---------- | ------------------------------- |
| テストフレームワーク | Jest                            |
| スキーマファイル   | `document/swagger/openapi.yml`  |
| 参照方法       | `js-yaml`等を用いて解析し、mock作成や型生成に活用 |

### 2.2.設定
下記のファイルを修正してください。

* frontend/__tests__/swagger.spec.ts

	```ts
	import fs from 'fs';
	import yaml from 'js-yaml';

	describe('OpenAPI仕様チェック', () => {
		it('openapi.ymlが正しい形式であること', () => {
			const file = fs.readFileSync('document/swagger/openapi.yml', 'utf8');
			const spec = yaml.load(file) as any;
			expect(spec.openapi).toBe('3.0.0');
		});
	});

	```


<br>
<br>

## 3.backendコンテナの設定
---

### 2.1.構成

| 項目         | 内容                             |
| ---------- | ------------------------------ |
| テストフレームワーク | RSpec                          |
| スキーマファイル   | `document/swagger/openapi.yml` |
| 参照方法       | `yaml`として読み込み、request specで検証  |


### 2.2.設定

下記のファイルを修正してください。

* spec/requests/api_spec.rb

	```ruby
	# spec/requests/api_spec.rb
	require 'swagger_helper'

	RSpec.describe 'APIドキュメント整合性確認', type: :request do
		it 'openapi.ymlがパースできること' do
			yaml_path = Rails.root.join('../../document/swagger/openapi.yml')
			spec = YAML.load_file(yaml_path)
			expect(spec['openapi']).to eq('3.0.0')
		end
	end
	```



<br>
<br>

## 4.swaggerの設定

<br>
<br>

## 5.動作テスト

### 5.1. フロントエンド


### 5.2. バックエンド


[PREVIOUS](./12_backend_setup.md)

[NEXT](./30_switch_readme.md) 

[RETURN README](../../README.md)