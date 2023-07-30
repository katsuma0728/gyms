class Public::RelationshipsController < ApplicationController
  # フォローするとき
  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end
  
  # フォローを外すとき
  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end
  
  # フォロー一覧
  def followings
    user = User.find(params[:user_id])
    @users = user.followings.order(created_at: :desc).page(params[:page]).per(2)
  end
  
  # フォロワー一覧
  def followers
    user = User.find(params[:user_id])
    @users = user.followers.order(created_at: :desc).page(params[:page]).per(2)
  end
end
