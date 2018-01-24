Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
resources :restaurants, only: [:index, :show]
resources :categories, only: :show
root "restaurants#index"   #請加入這行程式碼
namespace :admin do
    root "restaurants#index"
    resources :restaurants
    resources :categories
  end
end
