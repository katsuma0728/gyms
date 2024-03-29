class Tag < ApplicationRecord
  has_many :post_tags, dependent: :destroy, foreign_key: "tag_id"
  has_many :post_blogs, through: :post_tags, dependent: :delete_all

  validates :name, uniqueness: true, presence: true
end
