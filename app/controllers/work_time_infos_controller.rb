class WorkTimeInfosController < ApplicationController
  def show
    @wti = WorkTimeInfo.find(params[:code])
  end
end
