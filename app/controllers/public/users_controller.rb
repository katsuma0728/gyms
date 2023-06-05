class Public::UsersController < ApplicationController

  before_action :ensure_general_user, only: [:update, :unsubscribe]

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

  def ensure_general_user
    if current_user.email == "guest@example.com"
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:profile_image, :name, :birth_date, :sex, :introduction, :email)
  end
end
