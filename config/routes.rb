Rails.application.routes.draw do
  devise_for :users
  resource :work_time_info, only: [:show]
  resource :work_time, only: [:show]
  resource :notifier, only: [:show, :create, :destroy]

  namespace :jobs, as: nil do
    resources :run_notifiers_jobs, only: [:create], path: 'run_notifiers'
  end

  root 'work_times#show'
end
