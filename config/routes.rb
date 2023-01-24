Rails.application.routes.draw do
  root to: "pages#home"
  devise_for :users
  resources :lists, except: [:edit, :update] do
    resources :reviews, only: [:index, :create, :show]
  end
  resources :reviews, only: :destroy
  resources :products do
    resources :bookings, only: [:new, :create, :destroy]
  end
  resources :bookings, only: [:index]
end
