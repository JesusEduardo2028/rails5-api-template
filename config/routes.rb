Rails.application.routes.draw do
  apipie
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', sign_up: 'sign_up' }
  constraints subdomain: 'api' do
    namespace :api , path: '/' ,defaults: { format: :json } do
      mount_devise_token_auth_for 'User', at: 'auth'
      resources :items
    end
  end
  root to: "static_pages#home"
end
