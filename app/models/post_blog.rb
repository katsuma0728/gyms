class PostBlog < ApplicationRecord
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one_attached :image
  enum status: { published: 0, draft: 1 }


  def self.search(keyword)
    #投稿タイトル、内容、ユーザーネームで検索
    where(['title LIKE ? OR blog LIKE ? OR users.name LIKE ?', "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"])
  end

  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end
end
