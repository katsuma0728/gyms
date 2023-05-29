class PostTag < ApplicationRecord
  belongs_to :post_blog
  belongs_to :tag
end
