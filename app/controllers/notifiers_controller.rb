class NotifiersController < ApplicationController
  def show
  end

  def create
    Notifier.create(user_id: current_user.id)
  end
end
