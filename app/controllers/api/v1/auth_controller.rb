class Api::V1::AuthController < ApplicationController
  def login
    user = User.find_by(account_name: params[:account_name])

    if user&.authenticate(params[:password])
      token = generate_jwt_token(user)
      render json: {
        message: "ログインしました",
        user: {
          id: user.id,
          account_name: user.account_name
        },
        token: token
      }
    else
      render json: {
        error: "ユーザー名またはパスワードが正しくありません"
      }, status: :unauthorized
    end
  end

  private

  def generate_jwt_token(user)
    payload = {
      user_id: user.id,
      exp: 24.hours.from_now.to_i
    }
    JWT.encode(payload, Rails.application.secret_key_base)
  end
end
