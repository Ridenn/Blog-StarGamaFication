Rails.application.routes.draw do
  root to: "home#index"

  get 'home', to: "home#index"
  get 'obrigado', to: "home#thanks", :as => 'thanks'
  get 'contato', to: "home#contact", :as => 'contact'

  resources :posts
  resources :leads
  resources :contents

  devise_for :admins
  mount Ckeditor::Engine => '/ckeditor'
end
