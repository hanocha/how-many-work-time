class NotifiersController < ApplicationController
  def show
    @notifier = current_user.notifier || Notifier.new
  end

  def create
    Notifier.create(notifier_params)
    redirect_to notifier_path
  end

  private

  def notifier_params
    params.require(:notifier).permit(:user_id, :slack_user_name)
  end
end
