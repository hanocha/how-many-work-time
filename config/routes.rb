Rails.application.routes.draw do
  devise_for :users
  resource :work_time_info, only: [:show]
  resource :work_time, only: [:show]
  resource :notifier, only: [:show, :create]

  root 'work_times#show'
end
