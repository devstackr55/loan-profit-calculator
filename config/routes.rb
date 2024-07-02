# frozen_string_literal: true

Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  resources :calculators, only: %i[index create]

  root to: 'calculators#index'
end
