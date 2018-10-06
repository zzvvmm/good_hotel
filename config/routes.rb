Rails.application.routes.draw do
  get 'searchs/search_result'
  get 'reviews/review'
  resources :hotels, only: [:index]
  root to: "hotels#index"
end
