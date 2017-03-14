class WorkTimesController < ApplicationController
  before_action :require_sign_in

  def show
    @wti = WorkTimeInfo.find(current_user.code)
    return redirect_to edit_user_registration_path if @wti.std_work_days == 0
  end

  private

  def require_sign_in
    redirect_to new_user_session_path unless user_signed_in?
  end
end
