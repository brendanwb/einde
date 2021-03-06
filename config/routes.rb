Rails.application.routes.draw do
  scope module: :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :products, only: [:create, :show, :update]
      resources :users, only: [:create]
    end
  end
end
