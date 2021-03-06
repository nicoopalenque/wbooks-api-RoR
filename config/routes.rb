require 'sidekiq/web' 
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  namespace :admin do
    resources :users
    resources :books
    resources :rents
    resources :book_suggestions

    root to: "users#index"
  end
  root to: 'main#index'
  mount_devise_token_auth_for 'User', at: 'auth', skip: [:omniauth_callbacks]
  namespace :api do
    namespace :v1 do
      resources :open_library, only: [:index, :show], param: :isbn
      resources :book, only: %i[index show]
      resources :book_suggestion, only: %i[create index]
      resources :user, only: :index do
        resources :rent, only: %i[create index]
      end
      scope :rent do
        get '/book_rankings', to: 'rent#book_ranking'
        get '/active', to: 'rent#active'
      end
    end
  end
  mount Sidekiq::Web => '/sidekiq'
end
