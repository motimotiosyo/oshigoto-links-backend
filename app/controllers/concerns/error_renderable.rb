module ErrorRenderable
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError, with: :render_internal_server_error
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
    rescue_from ActionController::ParameterMissing, with: :render_bad_request
  end

  private

  # 400 Bad Request
  def render_bad_request(exception = nil)
    render_error(
      status: :bad_request,
      code: "VALIDATION_ERROR",
      message: "リクエストが不正です",
      details: exception&.message
    )
  end

  # 401 Unauthorized
  def render_unauthorized(message = "認証が必要です")
    render_error(
      status: :unauthorized,
      code: "UNAUTHORIZED",
      message: message
    )
  end

  # 403 Forbidden
  def render_forbidden(message = "アクセスが拒否されました")
    render_error(
      status: :forbidden,
      code: "FORBIDDEN",
      message: message
    )
  end

  # 404 Not Found
  def render_not_found(exception = nil)
    render_error(
      status: :not_found,
      code: "NOT_FOUND",
      message: "リソースが見つかりません"
    )
  end

  # 422 Unprocessable Entity
  def render_unprocessable_entity(exception)
    details = {}
    if exception.respond_to?(:record) && exception.record&.errors&.any?
      exception.record.errors.each do |error|
        attribute = error.attribute
        details[attribute] ||= []
        details[attribute] << error.message
      end
    end

    render_error(
      status: :unprocessable_entity,
      code: "VALIDATION_ERROR",
      message: "バリデーションエラーが発生しました",
      details: details
    )
  end

  # 429 Too Many Requests
  def render_rate_limited(message = "リクエスト制限に達しました")
    render_error(
      status: :too_many_requests,
      code: "RATE_LIMITED",
      message: message
    )
  end

  # 500 Internal Server Error
  def render_internal_server_error(exception = nil)
    Rails.logger.error "Internal Server Error: #{exception&.message}"
    Rails.logger.error exception&.backtrace&.join("\n") if exception

    render_error(
      status: :internal_server_error,
      code: "INTERNAL",
      message: "サーバーエラーが発生しました"
    )
  end

  # 共通エラーレスポンス形式
  def render_error(status:, code:, message:, details: nil)
    error_response = {
      error: {
        code: code,
        message: message,
        request_id: request.request_id || SecureRandom.uuid
      }
    }

    error_response[:error][:details] = details if details.present?

    render json: error_response, status: status
  end
end
