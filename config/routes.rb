Rails.application.routes.draw do
  root "pages#top"
  get "up" => "rails/health#show", as: :rails_health_check

  resource :signup_email, only: %i[new create] do
    get :complete, on: :collection
  end

  resource :signup_profile, only: %i[edit update]
  resources :initial_plants, only: %i[index create]
  resource :home, only: :show

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
