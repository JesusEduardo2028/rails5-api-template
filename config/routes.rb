Rails.application.routes.draw do
  get 'console/show'

  apipie
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', sign_up: 'sign_up' }
  constraints subdomain: 'api' do
    namespace :api , path: '/' ,defaults: { format: :json } do
      mount_devise_token_auth_for 'User', at: 'auth'
      resources :items
    end
  end

  authenticated :user do
    root :to => "console#show" , :as => "authenticated_user_root"
  end
  root to: "static_pages#home"
end
