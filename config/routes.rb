Rails.application.routes.draw do
  devise_for :users
  resource :work_time_info, only: [:show]

  root 'home#index'
end
