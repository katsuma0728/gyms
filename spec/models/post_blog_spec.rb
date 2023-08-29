# frozen_string_literal: true

require "rails_helper"

RSpec.describe "PostBlogモデルのテスト", type: :model do
  describe "バリデーションのテスト" do
    let(:user) { create(:user) }
    let!(:post_blog) { build(:post_blog, user_id: user.id) }

    context "titleカラム" do
      it "空欄でないこと" do
        post_blog.title = ""
        expect(post_blog.valid?).to eq false
      end
      it "20文字以下であること: 20文字は〇" do
        post_blog.title = Faker::Lorem.characters(number: 20)
        expect(post_blog.valid?).to eq true
      end
      it "20文字以下であること: 21文字は×" do
        post_blog.title = Faker::Lorem.characters(number: 21)
        expect(post_blog.valid?).to eq false
      end
    end

    context "blogカラム" do
      it "空欄でないこと" do
        post_blog.blog = ""
        expect(post_blog.valid?).to eq false
      end
      it "200文字以下であること: 200文字は〇" do
        post_blog.blog = Faker::Lorem.characters(number: 200)
        expect(post_blog.valid?).to eq true
      end
      it "200文字以下であること: 201文字は×" do
        post_blog.blog = Faker::Lorem.characters(number: 201)
        expect(post_blog.valid?).to eq false
      end
    end
  end

  describe "アソシエーションのテスト" do
    context "Userモデルとの関係" do
      it "N:1となっている" do
        expect(PostBlog.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end
