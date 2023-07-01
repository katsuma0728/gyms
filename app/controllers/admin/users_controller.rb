class Admin::UsersController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :authenticate_admin!

  def index
    @users = User.all
  end

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
       flash[:notice] = "ユーザー情報を更新しました"
       redirect_to admin_user_path(@user.id)
    else
      render :edit
    end
  end


  private

  def user_params
    params.require(:user).permit(:profile_image, :email, :name, :birth_date, :sex, :introduction, :is_deleted)
  end
end
