Rails.application.routes.draw do
  root to: "homepages#index"
  resources :trips
  resources :passengers
  resources :drivers

end
