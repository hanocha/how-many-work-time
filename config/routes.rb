Rails.application.routes.draw do
  resource :work_time_info, only: [:show]

  root 'home#index'
end
