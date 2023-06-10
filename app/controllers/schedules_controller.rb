class SchedulesController < ApplicationController

# カレンダーのカスタマイズ、日曜日を始まりに
before_action :set_beginning_of_week


  # ゲストユーザー管理
  # before_action :ensure_general_user, only: [:create]

  def index
    @user = current_user
    @schedules = @user.schedules.all
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

  # カレンダーのカスタマイズ、日曜日を始まりに
  def set_beginning_of_week
    Date.beginning_of_week = :sunday
  end
end
