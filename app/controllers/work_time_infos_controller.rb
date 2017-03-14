class WorkTimeInfosController < ApplicationController
  def show
    @wti = WorkTimeInfo.find(params[:code])
    
    # 誤ったコードが入力された時にどうするかを考えないといけない
    # そもそも Deprecated なものなのでそこまで考える必要は無い気もする
    # return redirect_to edit_user_registration_path if @wti.std_work_days == 0
  end
end
