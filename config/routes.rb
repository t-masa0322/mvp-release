Rails.application.routes.draw do
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

  resources :plants, only: %i[index]
  post "plants/:id/select", to: "plants#select", as: :select_plant

  resource :exercise_log, only: %i[new create] do
    get :complete, on: :collection
  end

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
