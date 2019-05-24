Rails.application.routes.draw do
  resources :question, only: [:show]
  get 'course/index'
  get 'welcome/index'
  root 'welcome#index'
end
