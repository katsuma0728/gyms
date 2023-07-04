class PostBlog < ApplicationRecord
  #これがないとストロングパラメータでnameを追加している関係で、保存時にUnknown attributeエラーが発生する。
  attr_accessor :name

  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags, dependent: :delete_all
  has_one_attached :image
  enum status: { published: 0, draft: 1 }

  validates :title, presence: true
  validates :blog, presence: true, length: { maximum: 200 }

  def self.search(keyword)
    #投稿タイトル、内容、ユーザーネームで検索
    where(['title LIKE ? OR blog LIKE ? OR users.name LIKE ?', "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"])
  end

  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_fill: [width, height]).processed
  end

  def save_tag(sent_tags)
    # 同じ文字列のタグを１つにする
    sent_tags = sent_tags.uniq
   # タグが存在していれば、タグの名前を配列として全て取得
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    # 現在取得したタグから送られてきたタグを除いてoldtagとする
    old_tags = current_tags - sent_tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = sent_tags - current_tags

    # 古いタグを消す
    old_tags.each do |old|
      self.tags.delete Tag.find_by(name: old)

      check_tag = Tag.find_by(name: old)
      if check_tag.post_blogs.count == 0
        check_tag.destroy
      end
    end

    # 新しいタグを保存
    new_tags.each do |new|
      new_post_tag = Tag.find_or_create_by(name: new)
      tags << new_post_tag
   end
  end
end
