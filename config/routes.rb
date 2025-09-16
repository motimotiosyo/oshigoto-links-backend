Rails.application.routes.draw do
  get "/healthz", to: "healthz#show"
  namespace :api do
    namespace :v1 do
      get :ping, to: "pings#show"  # TODO: 開発後に削除
      resources :experience_posts, only: [ :index, :show, :create, :update, :destroy ]
      
      # ユーザー登録
      resources :users, only: [ :create ]
      
      # 認証
      namespace :auth do
        post :login
      end
    end
  end
end
