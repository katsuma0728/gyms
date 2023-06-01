class Activity < ApplicationRecord
  belongs_to :subject, polymorphic: true

  enum action_type: { liked_the_post_blog: 0, commented_on_the_post_blog: 1}
end
