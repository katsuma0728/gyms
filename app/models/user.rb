class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_many :post_blogs, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :schedules, dependent: :destroy

  has_one_attached :profile_image
  enum sex: { 男性: 0, 女性: 1}

  # 生年月日から年齢を取得　（現在-生年月日）/ 10000
  def age
    (Time.now.in_time_zone('Tokyo').strftime('%Y%m%d').to_i - self.birth_date.strftime('%Y%m%d').to_i) / 10000
  end

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  # ゲストログイン
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end
end
