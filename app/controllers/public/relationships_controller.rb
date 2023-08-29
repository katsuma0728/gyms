class Public::RelationshipsController < ApplicationController
  # ゲストユーザー管理
  include AjaxHelper
  before_action :ensure_general_user, only: [:create]

  # フォローするとき
  def create
    @user = User.find(params[:user_id])
    follow = Relationship.create(follower_id: params[:user_id], follow_id: current_user.id)
    follow.save
    # redirect_to request.referer
  end

  # フォローを外すとき
  def destroy
    @user = User.find(params[:user_id])
    unfollow = Relationship.find_by(follower_id: params[:user_id], follow_id: current_user.id)
    unfollow.destroy
    # redirect_to request.referer
  end

  # フォロー一覧
  def followings
    @user = User.find(params[:user_id])
    @users = @user.followings.order(created_at: :desc).page(params[:page]).per(10)
  end

  # フォロワー一覧
  def followers
    @user = User.find(params[:user_id])
    @users = @user.followers.order(created_at: :desc).page(params[:page]).per(10)
  end

  private
    # ゲストユーザー管理
    def ensure_general_user
      if current_user.email == "guest@example.com"
        respond_to do |format|
        format.js { render ajax_redirect_to(root_path) }
      end
      end
    end
end
