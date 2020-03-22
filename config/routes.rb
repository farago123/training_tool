Rails.application.routes.draw do
  root 'courses#index'
  devise_for :users
end
