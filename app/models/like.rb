class Like < ApplicationRecord

  belongs_to :user
  belongs_to :post_blog

  has_one :activity, as: :subject, dependent: :destroy

  after_create_commit :create_activities

  def redirect_path
    "/#{post_blog.user.user_id}/post_blogs/#{post_blog.id}"
  end

  def name
    user.name
  end

  private

  def create_activities
    Activity.create!(subject: self, user_id: post_blog.user.id, action_type: Activity.action_types[:liked_the_post_blog] )
  end
end
