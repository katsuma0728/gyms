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

  # フォローをした、されたの関係
  has_many :relationships, class_name: "Relationship", foreign_key: "follow_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # 一覧表示をするための記述
  has_many :followings, through: :relationships, source: :follower
  has_many :followers, through: :reverse_of_relationships, source: :follow

  validates :name, presence: true, uniqueness: true, length: { maximum: 20 }
  validates :introduction, presence: true
  validates :email, presence: true, uniqueness: true

  has_one_attached :profile_image
  enum sex: { 男性: 0, 女性: 1 }

  # 生年月日から年齢を取得　（現在-生年月日）/ 10000
  def age
    (Time.now.in_time_zone("Tokyo").strftime("%Y%m%d").to_i - self.birth_date.strftime("%Y%m%d").to_i) / 10000
  end

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join("app/assets/images/no_image.jpg")
      profile_image.attach(io: File.open(file_path), filename: "default-image.jpg", content_type: "image/jpeg")
    end
    profile_image.variant(resize_to_fill: [width, height]).processed
  end

  # ゲストログイン
  def self.guest
    find_or_create_by!(email: "guest@example.com") do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲストユーザー"
      user.introduction = "ゲストでログイン"
      user.birth_date = DateTime.now
    end
  end

  # フォローしたとき
  def follow(user_id)
    relationships.create(follower_id: user_id)
  end

  # フォローを外したとき
  def unfollow(user_id)
    relationships.find_by(follower_id: user_id).destroy
  end

  # フォローしているか判定
  def following?(user)
    followings.include?(user)
  end
end
