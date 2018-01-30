Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :restaurants, only: [:index, :show] do
      resources :comments, only: [:create, :destroy]


      # 瀏覽所有餐廳的最新動態
      collection do
        get :feeds
      end

      # 瀏覽個別餐廳的 Dashboard
      member do
        get :dashboard
        post :favorite
        post :unfavorite
      end
      member do
        post :like
        post :unlike
      end
    end

resources :users, only: [:show, :edit, :update]
resources :categories, only: :show
root "restaurants#index"   #請加入這行程式碼
namespace :admin do
    root "restaurants#index"
    resources :restaurants
    resources :categories
  end
end
