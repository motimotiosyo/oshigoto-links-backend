# Committee configuration for OpenAPI contract validation
Rails.application.configure do
  # OpenAPI契約検証の設定
  config.middleware.use Committee::Middleware::RequestValidation,
    schema_path: Rails.root.join('docs', 'openapi.yaml'),
    strict: true,
    validate_success_only: false,
    # 開発・テスト環境でのみ有効化
    # 本番環境では無効化してパフォーマンスを向上
    accept_request_filter: -> (request) {
      !Rails.env.production? && request.path.start_with?('/api/')
    }

  config.middleware.use Committee::Middleware::ResponseValidation,
    schema_path: Rails.root.join('docs', 'openapi.yaml'),
    # レスポンス検証も開発・テスト環境でのみ有効化
    accept_request_filter: -> (request) {
      !Rails.env.production? && request.path.start_with?('/api/')
    }

  # ログレベル設定
  Committee.logger = Rails.logger
end if defined?(Committee)