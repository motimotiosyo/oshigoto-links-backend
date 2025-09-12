Rails.application.routes.draw do
  get "/healthz", to: "healthz#show"
  namespace :api do
    namespace :v1 do
      get :ping, to: "pings#show"
    end
  end
end
