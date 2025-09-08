Rails.application.routes.draw do
  get "nutrition_logs/index"
  get "entries/index"
  get "entries/show"
  get "dashboards/show"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Dashboard (non-resource routes)
  # Run the show action in the DashboardController
  get "/dashboard", to: "dashboards#show"

  # entries and nested nutrition logs
  resources :entries, only: [:index, :show] do
    # show nutrition logs that belong to specific entries
    resources :nutrition_logs, only: [:index]
  end

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
