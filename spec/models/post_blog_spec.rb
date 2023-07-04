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
end
