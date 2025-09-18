Rails.application.routes.draw do

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Dashboard (non-resource routes)
  get "/dashboard", to: "dashboards#show"

  # entries and nested nutrition logs (resourceful routes)
  resources :entries, only: [:index, :show] do
    resources :nutrition_logs, only: [:index]
  end
# maybe set a home page later
# root "dashboards#show"
end
