Rails.application.routes.draw do
  root to: "pages#home"
  devise_for :users
  resources :lists, except: [:edit, :update] do
    resources :reviews, only: [:index, :create, :show]
  end
  resources :reviews, only: :destroy
  resources :products
  resources :bookings, only: [:new, :create, :index]
  get "products/:id/bookings/new", to: "bookings#new"
end
