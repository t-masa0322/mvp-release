Rails.application.routes.draw do
  root "pages#top"
  get "up" => "rails/health#show", as: :rails_health_check

  resource :signup, only: %i[new create]
  resource :signup_profile, only: %i[edit update]
  resources :initial_plants, only: %i[index create]
  resource :home, only: :show

  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  resource :password_reset, only: %i[new create edit update]
  resource :mypage, only: %i[show edit update]

  resources :plants, only: %i[index show]
  post "plants/:id/select", to: "plants#select", as: :select_plant

  resources :exercise_logs, only: %i[index new create edit update destroy] do
    get :complete, on: :collection
    get "date/:date", to: "exercise_logs#day", on: :collection, as: :by_date
  end

  resources :posts, only: %i[index new create show edit update destroy]

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
