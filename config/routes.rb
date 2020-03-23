Rails.application.routes.draw do
  root 'courses#index'
  resource :courses
  post 'courses/signup' => 'courses#signup'
  get 'courses/mycourses' => 'courses#mycourses'
  devise_for :users
end
