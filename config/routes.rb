Rails.application.routes.draw do
  root 'courses#index'
  resource :courses
  post 'courses/signup' => 'courses#signup'
  devise_for :users
end
