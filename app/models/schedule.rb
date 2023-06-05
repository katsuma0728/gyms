class Schedule < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :memo, presence: true
end
