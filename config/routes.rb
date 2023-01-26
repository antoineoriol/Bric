Rails.application.routes.draw do
  devise_for :users

  root to: 'pages#home'

  get '/users/sign_out' => 'devise/sessions#destroy'

  get 'my_products', to: 'products#my_products'

  get '/bookings/:id/accept', to: 'bookings#accept', as: 'accept_booking'
  get '/bookings/:id/reject', to: 'bookings#reject', as: 'reject_booking'


  resources :products do
    resources :bookings, only: %i[new create destroy]

    collection do
      get :search
    end

    member do
      get :reviews
    end

    resources :bookings, only: [ :new, :create, :destroy ]
  end

  resources :bookings, except: [ :new, :index, :create ] do
    resources :reviews, only: [ :new, :create ]

  end

  resources :reviews, except: [ :new, :create ]

  get '/bookings', to: 'bookings#index'

  get '/error', to: 'errors#not_found'

end
