class Schedule < ApplicationRecord
  belongs_to :user, dependent: :destroy
end
