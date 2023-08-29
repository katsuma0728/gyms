class Relationship < ApplicationRecord
  belongs_to :follow, class_name: "User"
  belongs_to :follower, class_name: "User"

  has_one :activity, as: :subject, dependent: :destroy

  # フォロー後
  after_create_commit :create_activities

  def name
    follow.name
  end

  private
    def create_activities
      Activity.create!(subject: self, user_id: follower.id, action_type: Activity.action_types[:user_follow])
    end
end
