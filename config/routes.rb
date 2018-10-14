Rails.application.routes.draw do
  get 'searchs/search_result'
  resources :hotel_reviews
  resources :hotels, only: [:index]
  root to: "hotels#index"
end
