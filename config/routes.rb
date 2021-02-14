Rails.application.routes.draw do
  resources :posts
  root 'application#root'
end
