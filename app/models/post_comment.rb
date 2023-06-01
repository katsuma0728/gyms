class PostComment < ApplicationRecord
  
  belongs_to :user
  belongs_to :post_blog
  
  has_one :activity, as: :subject, dependent: :destroy
  
end
