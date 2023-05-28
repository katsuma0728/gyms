class Public::UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to  user_path(@user.id)
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

  private

  def user_params
    params.require(:user).permit(:profile_image, :name, :birth_date, :sex, :introduction, :email)
  end
end
