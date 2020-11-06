Rails.application.routes.draw do
  root to: "homepages#index"

  resources :trips
  resources :passengers do
    resources :trips, only: [:index, :new]
  end
  resources :drivers do
    resources :trips, only: [:index]
  end
  resources :homepages

  patch '/trips/:id/complete', to: 'trips#complete', as: 'complete_trip'
end
