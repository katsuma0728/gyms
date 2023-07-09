class Schedule < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { maximum: 20 }
  validates :memo, length: { maximum: 200 }
end
