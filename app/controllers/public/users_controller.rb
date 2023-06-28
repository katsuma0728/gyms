class Public::UsersController < ApplicationController

  before_action :ensure_general_user, only: [:update, :unsubscribe]
  # カレンダーのカスタマイズ、日曜日を始まりに
  before_action :set_beginning_of_week

  def show
    @user = User.find(params[:id])
    @schedules = @user.schedules
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
       flash[:notice] = "マイページを更新しました"
       redirect_to  user_path(@user.id)
    else
      render :edit
    end
  end

  def unsubscribe
    @user = User.find(params[:id])
  end

  def withdraw
    @user = User.find(params[:id])
    @user.update(is_deleted: :true)
    reset_session
    redirect_to root_path
  end

  def ensure_general_user
    if current_user.email == "guest@example.com"
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:profile_image, :name, :birth_date, :sex, :introduction, :email)
  end

  # カレンダーのカスタマイズ、日曜日を始まりに
  def set_beginning_of_week
    Date.beginning_of_week = :sunday
  end
end
