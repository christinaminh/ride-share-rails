Rails.application.routes.draw do
<<<<<<< HEAD
  root to: "homepages#index"
=======

  root to: "homepages#index" #??

>>>>>>> 30ce0439c882f847576727682c2993b4bf05915b
  resources :trips
  resources :passengers
  resources :drivers

end
