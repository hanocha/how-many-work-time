class NotifiersController < ApplicationController
  def create
    Notifier.create(user_id: current_user.id)
  end
end
