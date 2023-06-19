class Admin::SchedulesController < ApplicationController

  def show
    @schedule = Schedule.find(params[:id])
  end

  def edit
    @schedule = Schedule.find(params[:id])
  end

  def update
    @schedule = Schedule.find(params[:id])
    if  @schedule.update(schedule_params)
        redirect_to admin_user_path(@schedule.user.id)
    else
      render :edit
    end
  end

  def destroy
    @schedule = Schedule.find(params[:id])
    @schedule.destroy
    redirect_to admin_user_path(@schedule.user.id)
  end


  private

  def schedule_params
    params.require(:schedule).permit(:user_id, :title, :memo, :start_time)
  end
end
