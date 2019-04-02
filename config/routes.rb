Rails.application.routes.draw do
  get 'course/index'
  get 'welcome/index'
  root 'welcome#index'
end
