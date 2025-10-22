Rails.application.routes.draw do
  # Health check
  get "up" => "rails/health#show", as: :rails_health_check
  
  # --- public auth pages ---
  resource :session, only: [:new, :create, :destroy], controller: :sessions
  resources :users, only: [:new, :create]
  # login to be the public landing page
  root "sessions#new"

  # --- protected pages (require login) ---
  get "/dashboard", to: "dashboards#show"

  # entries and nested nutrition logs (resourceful routes)
  resources :entries, only: [:index, :show] do
    # nutrition logs under a specific entry
    resources :nutrition_logs, only: [:new, :create, :edit, :update, :destroy]
  end

  # resources are owned by a user
  resources :users, only: [] do
    resources :entries, only: [:new, :create, :edit, :update, :destroy]

    resources :supplements, except: [:index, :show]

    resources :reminders, except: [:index, :show] do
      member do
        patch :complete
        patch :uncomplete
      end
    end
  end

  # nutrition logs are tied to an entry
  resources :entries, only: [] do
    resources :nutrition_logs, only: [:new, :create, :edit, :update]
  end

end
