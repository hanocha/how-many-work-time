class NotifiersController < ApplicationController
  before_action :require_sign_in

  def show
    @notifier = current_user.notifier || Notifier.new
  end

  def create
    Notifier.create(notifier_params)
    redirect_to notifier_path
  end

  def destroy
    current_user.notifier.delete
    redirect_to notifier_path
  end

  private

  def notifier_params
    params.require(:notifier).permit(:user_id, :slack_user_name)
  end

  def require_sign_in
    redirect_to new_user_session_path unless user_signed_in?
  end
end
