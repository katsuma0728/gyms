class ActivitiesController < ApplicationController


  def index
    #作成日が新しい順で表示。
     @activities = current_user.activities.order(created_at: :desc).page(params[:page]).per(10)
  end

  def read
    activity = current_user.activities.where(user_id: [current_user.id])
    unless activity.read?
      # 通知を読んだらtrue
      activity.update(cheacked: true)
    end
    # 各通知もとへリダイレクト
    redirect_to activity.subject.redirect_path
  end


end
