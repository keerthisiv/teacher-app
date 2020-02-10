Rails.application.routes.draw do
  resources :log_events
  devise_for :teachers
  root to: 'log_events#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
