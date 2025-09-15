Rails.application.routes.draw do
  get "/healthz", to: "healthz#show"
  namespace :api do
    namespace :v1 do
      get :ping, to: "pings#show"  # TODO: 開発後に削除
      resources :experiences, only: [ :index, :show, :create, :update, :destroy ]
    end
  end
end
