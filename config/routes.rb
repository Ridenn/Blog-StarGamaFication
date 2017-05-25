Rails.application.routes.draw do
  root to: "home#index"

  get 'home', to: "home#index", :as => 'home'
  get 'obrigado', to: "home#thanks", :as => 'thanks'
  get 'contato', to: "home#contact", :as => 'contact'

  get 'google1806d511e453e0c0.html', to: "home#google_validation"

  get 'home/pdf', to: 'home#pdf'

  resources :posts
  resources :leads
  resources :contents

  devise_for :admins
  mount Ckeditor::Engine => '/ckeditor'
end
