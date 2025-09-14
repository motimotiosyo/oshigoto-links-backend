# Oshigoto Links Backend

エンジニア向け業界知識共有アプリケーションのRails API

## 概要

このプロジェクトは**Spec First**開発アプローチを採用しています。API仕様書（`docs/openapi.yaml`）を原本とし、バックエンド・フロントエンド両方がこの仕様に準拠して開発されます。

## API仕様書

**SSOT (Single Source of Truth)**: `docs/openapi.yaml`

- OpenAPI 3.0.3 形式
- /api/v1 エンドポイント
- Bearer認証 (JWT)
- エラーレスポンス統一
- ページネーション対応

## セットアップ

### 必要な環境

- Ruby 3.3.6
- Rails 7.2.x
- PostgreSQL 15+
- Node.js 20+ (Spectral用)

### インストール手順

```bash
# リポジトリクローン
git clone https://github.com/<ORG>/<REPO>.git
cd oshigoto-links-backend

# 依存関係インストール
bundle install

# データベース作成・マイグレーション
rails db:create
rails db:migrate

# サーバー起動
rails server
```

### API仕様書のLint

```bash
# Spectralをインストール (初回のみ)
npm install -g @stoplight/spectral-cli

# API仕様書をLint
spectral lint docs/openapi.yaml --fail-severity warn
```

## 開発フロー

### 仕様変更の手順

1. **Spec PR**: `docs/openapi.yaml` の変更 → レビュー・合意
2. **実装PR**: バックエンド・フロントエンドそれぞれで実装

### 破壊的変更の扱い

- **非破壊的変更**: v1.x でマイナー/パッチ更新（フィールド追加等）
- **破壊的変更**: `/api/v2` で新バージョン実装
  - 旧バージョンは Deprecated 告知 → 猶予期間 → EOL

## API仕様

### エンドポイント

- `GET /api/v1/experiences` - Experience一覧取得
- `GET /api/v1/experiences/:id` - Experience詳細取得
- `POST /api/v1/experiences` - Experience作成
- `PUT /api/v1/experiences/:id` - Experience更新
- `DELETE /api/v1/experiences/:id` - Experience削除

### 認証

```
Authorization: Bearer <JWT_TOKEN>
```

### エラーレスポンス形式

```json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "バリデーションエラーが発生しました",
    "details": {
      "title": ["は必須です"]
    },
    "request_id": "req_123456789"
  }
}
```

### ページネーション

- `X-Total-Count` ヘッダで総件数を返却
- `page`, `per_page`, `sort` パラメータ対応
- デフォルトソート: `sort=-created_at`

## テスト・品質管理

### API契約検証

- **committee-rails**: 開発・テスト環境でリクエスト/レスポンス検証
- OpenAPI仕様との乖離を自動検出

### CI/CD

GitHub Actionsで以下を実行:

1. **API仕様Lint**: Spectralによるopenapi.yamlの検証
2. **テスト実行**: RailsテストとAPI契約検証
3. **契約検証**: committee middleware による仕様準拠チェック

## プロジェクト構成

```
docs/
  openapi.yaml              # API仕様書 (SSOT)
app/
  controllers/
    api/v1/
      experiences_controller.rb # Experience CRUD API
    concerns/
      error_renderable.rb       # エラーハンドリング統一
  models/
    experience.rb              # Experienceモデル
config/
  initializers/
    committee.rb           # API契約検証設定
.github/
  workflows/
    api-spec-guard.yml     # CI/CD設定
  pull_request_template.md # PRテンプレート
CODEOWNERS                 # コードオーナー設定
```

## 運用ルール

### CODEOWNERS

- `/docs/*`: API仕様変更は必ずAPIオーナーの承認が必要
- 重要な設定ファイル・マイグレーションも要承認

### バージョニング

- セマンティックバージョニング準拠
- APIバージョン: `/api/v1`, `/api/v2`, ...
- 破壊的変更時は新バージョンで並行運用

## 今後の拡張計画

1. JWT認証実装
2. ユーザー管理機能
3. 業界・タグ管理
4. 質問・回答機能
5. Redocでの仕様書公開