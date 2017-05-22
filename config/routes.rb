Rails.application.routes.draw do
  get 'obrigado', to: "thanks#index"

  devise_for :admins
  mount Ckeditor::Engine => '/ckeditor'

  root to: "posts#index"

  resources :posts
  resources :leads
end
