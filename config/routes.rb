Rails.application.routes.draw do
  devise_for :users
  resource :work_time_info, only: [:show]

  root 'work_time_infos#show'
end
