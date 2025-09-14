# Committee configuration for OpenAPI contract validation
if defined?(Committee) && !Rails.env.production?
  Rails.application.configure do
    # OpenAPI契約検証の設定
    config.middleware.use Committee::Middleware::RequestValidation,
      schema_path: Rails.root.join('docs', 'openapi.yaml'),
      strict: true,
      validate_success_only: false,
      # APIパスのみ検証対象
      accept_request_filter: -> (request) {
        request.path.start_with?('/api/')
      }

    config.middleware.use Committee::Middleware::ResponseValidation,
      schema_path: Rails.root.join('docs', 'openapi.yaml'),
      # APIパスのみ検証対象
      accept_request_filter: -> (request) {
        request.path.start_with?('/api/')
      }
  end
end