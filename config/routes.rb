Rails.application.routes.draw do
  root "pages#top"
  get "up" => "rails/health#show", as: :rails_health_check

  resource :signup_email, only: %i[new create] do
    get :complete, on: :collection
  end
end