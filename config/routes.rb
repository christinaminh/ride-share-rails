Rails.application.routes.draw do
  # root to: "homepages#index"

  resources :trips
  resources :passengers do
    resources :trips, only: [:index, :new]
  end
  resources :drivers

end
