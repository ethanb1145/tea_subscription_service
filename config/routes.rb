Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :customers do
        resources :subscriptions, only: [:create, :index, :update]
      end
    end
  end
end