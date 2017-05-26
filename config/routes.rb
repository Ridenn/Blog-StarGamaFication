Rails.application.routes.draw do
  root to: "home#index"

  get 'home', to: "home#index", :as => 'home'
  get 'obrigado', to: "home#thanks", :as => 'thanks'
  get 'contato', to: "home#contact", :as => 'contact'

  get 'home/pdf', to: 'home#pdf'

  resources :posts
  resources :leads
  resources :contents

  get "/#{Rails.application.config.google_verification}.html", :to => redirect("/#{Rails.application.config.google_verification}.html")

  devise_for :admins
  mount Ckeditor::Engine => '/ckeditor'
end
