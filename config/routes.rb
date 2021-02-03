Rails.application.routes.draw do
  root 'courses#index'
  resource :courses
  post 'courses/signup' => 'courses#signup'
  get 'courses/mycourses' => 'courses#mycourses'
  post 'courses/update' => 'courses#update'
  post 'courses/delete_all' => 'courses#delete_all'
  get 'courses/instructing' => 'courses#instructing'
  devise_for :users
end
