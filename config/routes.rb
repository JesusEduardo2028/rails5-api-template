Rails.application.routes.draw do
  constraints subdomain: 'api' do
    namespace :api , path: '/' ,defaults: { format: :json } do
      resources :items
    end
  end
  root to: "static_pages#home"
end
