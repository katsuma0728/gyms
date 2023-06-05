class SchedulesController < ApplicationController

  # ゲストユーザー管理
  # before_action :ensure_general_user, only: [:create]

  def index
    @schedules = Schedule.all
    @schedule = Schedule.new
  end

  def new
    @schedule = Schedule.new
  end

  def create
    @schedule = Schedule.new(schedule_params)
    @schedule.user_id = current_user.id
    @schedule.save
    redirect_to schedules_path
  end

  def show
    @schedule = Schedule.find(params[:id])
  end

  def edit
    @schedule = Schedule.find(params[:id])
  end

  def update
    @schedule = Schedule.find(params[:id])
    @schedule.update(schedule_params)
    redirect_to schedules_path
  end

  def destroy
    @schedule = Schedule.find(params[:id])
    @schedule.destroy
    redirect_to schedules_path
  end

  # ゲストユーザー管理
  # def ensure_general_user
  #   if current_user.email == "guest@example.com"
  #     redirect_to root_path
  #   end
  # end

  private

  def schedule_params
    params.require(:schedule).permit(:user_id, :title, :memo, :start_time)
  end

end
