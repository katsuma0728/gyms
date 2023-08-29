class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post_blog

  has_one :activity, as: :subject, dependent: :destroy

  validates :comment, presence: true

  # コメント作成後
  after_create_commit :create_activities

  def name
    user.name
  end

  private
    def create_activities
      # 自分の投稿をコメントした場合は通知しない。
      unless self.user_id == post_blog.user.id
        Activity.create!(subject: self, user_id: post_blog.user.id, action_type: Activity.action_types[:commented_on_the_post_blog])
      end
    end
end
