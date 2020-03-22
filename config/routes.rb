Rails.application.routes.draw do
  root 'courses#index'
  resource :courses
  devise_for :users
end
