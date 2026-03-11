Rails.application.routes.draw do
  get 'mypages/show'
  get 'mypages/edit'
  get 'password_resets/new'
  get 'password_resets/create'
  get 'password_resets/edit'
  get 'password_resets/update'
  get 'sessions/new'
  root "pages#top"
  get "up" => "rails/health#show", as: :rails_health_check

  resource :signup_email, only: %i[new create] do
    get :complete, on: :collection
  end

  resource :signup_profile, only: %i[edit update]
  resources :initial_plants, only: %i[index create]
  resource :home, only: :show

  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  resource :password_reset, only: %i[new create edit update]

  resource :mypage, only: %i[show edit update]

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
