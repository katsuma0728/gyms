class Public::SchedulesController < ApplicationController

  # カレンダーのカスタマイズ、日曜日を始まりに
  before_action :set_beginning_of_week
  # ゲストユーザー管理
  before_action :ensure_general_user, only: [:create]

  def index
    @schedule = Schedule.new
    @user = current_user
    # parseでTime型を作る
    start_time = params[:start_date] ? Time.parse(params[:start_date]) : Time.current
    beginning_of_month = start_time.beginning_of_month
    end_of_month = start_time.end_of_month
    schedules = @user.schedules.where(start_time: beginning_of_month..end_of_month)
    # 日付順に表示
    @schedules = schedules.page(params[:page]).per(10).order(start_time: :asc)
  end

  def create
    @schedule = Schedule.new(schedule_params)
    @schedule.user_id = current_user.id
    if @schedule.save
       flash[:notice] = "カレンダーに新規登録しました"
       redirect_to schedules_path
    else
      @user = current_user
      schedules = @user.schedules.page(params[:page]).per(10)
      # 日付順に表示
      @schedules = schedules.order(start_time: :asc)
      render :index
    end
  end

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
        redirect_to schedules_path
    else
      render :edit
    end
  end

  def destroy
    @schedule = Schedule.find(params[:id])
    @schedule.destroy
    flash[:notice] = "削除しました"
    redirect_to schedules_path
  end



  private

  def schedule_params
    params.require(:schedule).permit(:user_id, :title, :memo, :start_time)
  end

  # ゲストユーザー管理
  def ensure_general_user
    if current_user.email == "guest@example.com"
      redirect_to root_path
    end
  end

  # カレンダーのカスタマイズ、日曜日を始まりに
  def set_beginning_of_week
    Date.beginning_of_week = :sunday
  end
end
