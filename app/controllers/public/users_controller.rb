class Public::UsersController < ApplicationController

  before_action :is_matching_login_user, only: [:edit, :update, :unsubscribe]
  before_action :ensure_general_user, only: [:update, :unsubscribe]
  # カレンダーのカスタマイズ、日曜日を始まりに
  before_action :set_beginning_of_week

  def show
    @user = User.find(params[:id])
    @schedules = @user.schedules
  end

  def posting
    @user = User.find(params[:id])
    @post_blogs = @user.post_blogs.published.order(created_at: :desc).page(params[:page]).per(5)
  end

  def likes
    @user = User.find(params[:id])
    likes = Like.where(user_id: @user.id).pluck(:post_blog_id)
    #@like_posts = PostBlog.find(likes)
    # ↑配列ではpage表示できない
    @like_posts = PostBlog.where(id: likes).order(created_at: :desc).page(params[:page]).per(5)
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
      flash[:notice] = @user.errors.full_messages.join("\n")
      @user = User.find(params[:id])
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


  private

  def user_params
    params.require(:user).permit(:profile_image, :name, :birth_date, :sex, :introduction, :email)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end

  # カレンダーのカスタマイズ、日曜日を始まりに
  def set_beginning_of_week
    Date.beginning_of_week = :sunday
  end

  def ensure_general_user
    if current_user.email == "guest@example.com"
      redirect_to root_path
    end
  end
end
