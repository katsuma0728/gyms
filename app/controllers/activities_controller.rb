class ActivitiesController < ApplicationController
  

  def index
    #作成日が新しい順で表示。
     @activities = current_user.activities.where.not(checked: true).order(created_at: :desc).page(params[:page]).per(10)
  end

  def read
    activity = current_user.activities.find(params[:id])
    unless activity.checked
      # 通知を読んだらtrue
      activity.update(checked: true)
    end
    # 各投稿もとへリダイレクト
    # いいねなら
    if activity.subject_type == 'Like'
    # sublect_idからpost_blog_idを取得
      redirect_to post_blog_path(Like.find(activity.subject_id).post_blog_id)
    # コメントなら
    elsif activity.subject_type == 'PostComment'
      redirect_to post_blog_path(PostComment.find(activity.subject_id).post_blog_id)
    end
  end

end
