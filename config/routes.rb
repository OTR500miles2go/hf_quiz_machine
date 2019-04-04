Rails.application.routes.draw do
  resources :question
  get 'course/index'
  get 'welcome/index'
  root 'welcome#index'
end
