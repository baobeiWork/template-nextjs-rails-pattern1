<div align="center">
    <img src="https://github.com/user-attachments/assets/db1f5f30-1965-4443-b50b-ced77514eaf7" alt="" width="100%">
</div>

## 目次
---

- [1. 概要](#1-概要)
- [2. 想定読者](#2-想定読者)
- [3. このテンプレートでできること](#3-このテンプレートでできること)
- [4. 主要構成要素](#4-主要構成要素)

<br>
<br>

## 1. 概要
---
本テンプレートは、Rails × Next.js を用いたモダンWebアプリケーション構築のスタート地点を提供するものです。
開発者がスムーズに立ち上がり、共通基盤の上でチーム開発・運用を進められるように設計されています。

<br>
<br>

## 2. 想定読者
---

- Rails / Next.jsのフルスタック開発者
- インフラ構築やデプロイを含めた業務に携わるエンジニア
- ドキュメントをベースにチーム開発を開始したいリーダー/PL

<br>
<br>

## 3. このテンプレートでできること
---

- ローカル開発環境の即時立ち上げ（Docker）
- 本番運用を想定したAWS構成（Terraform）
- REST APIとSPAの統合開発
- RSpec / Jest を使ったテスト環境構築
- GitHub Actionsを使ったCI/CDのテンプレート提供

<br>
<br>

## 4. 主要構成要素
---

| 分類         | 内容                             |
|------------|----------------------------------|
| フロントエンド | Next.js（AppRouter） + MUI         |
| バックエンド   | Ruby on Rails（APIモード）         |
| インフラ     | AWS (ECS, RDS, S3, SES...)       |
| IaC        | Terraform                        |
| CI/CD      | GitHub Actions + Shell Scripts   |

<br>
<br>

[NEXT](./02_prerequisite.md)

[RETURN README](../../README.md)