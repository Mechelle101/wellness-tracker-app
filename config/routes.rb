Rails.application.routes.draw do
  # Health check
  get "up" => "rails/health#show", as: :rails_health_check
  
  # Dashboard (non-resource routes)
  get "/dashboard", to: "dashboards#show"
  root "dashboards#show"

  # entries and nested nutrition logs (resourceful routes)
  resources :entries, only: [:index, :show] do
    resources :nutrition_logs, only: [:index]
  end

  # resources are owned by a user
  resources :users, only: [] do
    resources :entries, only:[:new, :create, :edit, :update]
    # reminders belong to a user
    resources :reminders, only:[:new, :create, :edit, :update]
  end

  # nutrition logs are tied to an entry
  resources :entries, only: [] do
    resources :nutrition_logs, only: [:new, :create, :edit, :update]
  end
end
