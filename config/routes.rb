Rails.application.routes.draw do
  get "/healthz", to: "healthz#show"

  namespace :api do
    namespace :v1 do
      get :ping, to: "pings#show"

      resources :questions, only: [ :index, :show, :create, :update, :destroy ] do
        # 回答へのいいね
        resources :answers, only: [] do
          resource :answer_like, only: [ :create, :destroy ]
        end

        # 質問へのいいね
        resource :question_like, only: [ :create, :destroy ]
      end

      # ユーザー登録
      resources :users, only: [ :create ]
      # 業界
      resources :industries, only: :index
      # 職種
      resources :occupations, only: :index

      # 認証
      namespace :auth do
        post :login
      end
    end
  end
end
