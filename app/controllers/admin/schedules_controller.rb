class Admin::SchedulesController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :authenticate_admin!

  def show
    @schedule = Schedule.find(params[:id])
  end

  def edit
    @schedule = Schedule.find(params[:id])
  end

  def update
    @schedule = Schedule.find(params[:id])
    if  @schedule.update(schedule_params)
      flash[:notice] = "カレンダーを更新しました"
      redirect_to admin_user_path(@schedule.user.id)
    else
      render :edit
    end
  end

  def destroy
    @schedule = Schedule.find(params[:id])
    @schedule.destroy
    flash[:notice] = "削除しました"
    redirect_to admin_user_path(@schedule.user.id)
  end


  private
    def schedule_params
      params.require(:schedule).permit(:user_id, :title, :memo, :start_time)
    end
end
