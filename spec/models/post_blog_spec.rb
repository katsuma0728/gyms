# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PostBlogモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { post_blog.valid? }

    let(:user) { create(:user) }
    let!(:post_blog) { build(:post_blog, user_id: user.id) }
    
    context 'titleカラム' do
      it '空欄でないこと' do
        post_blog.title = ''
        is_expected.to eq false
      end
    end

    context 'bodyカラム' do
      it '空欄でないこと' do
        post_blog.body = ''
        is_expected.to eq false
      end
      it '200文字以下であること: 200文字は〇' do
        post_blog.body = Faker::Lorem.characters(number: 200)
        is_expected.to eq true
      end
      it '200文字以下であること: 201文字は×' do
        post_blog.body = Faker::Lorem.characters(number: 201)
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(PostBlog.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context 'PostCommentモデルとの関係' do
      it '1:Nとなっている' do
        expect(PostBlog.reflect_on_association(:post_comments).macro).to eq :has_many
      end
    end
    context 'Likeモデルとの関係' do
      it '1:Nとなっている' do
        expect(PostBlog.reflect_on_association(:likes).macro).to eq :has_many
      end
    end
    context 'PostTagモデルとの関係' do
      it '中間テーブルとして1:Nとなっている' do
        expect(PostBlog.reflect_on_association(:post_tags).macro).to eq :has_many
      end
    end
    context 'Tagモデルとの関係' do
      it '中間テーブルのPostTagモデルを通してN:Nとなっている' do
        expect(PostBlog.reflect_on_association(:tags).macro).to eq :has_many
      end
    end
  end
end
