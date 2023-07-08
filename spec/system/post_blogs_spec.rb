# frozen_string_literal: true

require 'rails_helper'

describe '投稿機能のテスト' do
  let!(:user) { create(:user, name: 'test_user', birth_date: Time.now, introduction: 'test', email: 'test@email.com', password: 'password') }
  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
    expect(current_path).to eq user_path(id:1)
  end
  
  describe '新規投稿のテスト' do
    before do
        visit new_post_blog_path
    end
    context 'フォームの入力が正常' do
      it '投稿を公開' do
        fill_in 'post_blog[title]', with: 'title'
        fill_in 'post_blog[blog]', with: 'example'
        find("#post_blog_status").find("option[value='published']").select_option
        click_button '投稿'
        expect(current_path).to eq post_blogs_path
        expect(page).to have_content "新規投稿しました"
      end
      it '下書きに保存' do
        fill_in 'post_blog[title]', with: 'title'
        fill_in 'post_blog[blog]', with: 'example'
        find("#post_blog_status").find("option[value='draft']").select_option
        click_button '投稿'
        expect(current_path).to eq post_blogs_path
        expect(page).to have_content "下書きに保存しました"
      end
    end
    context '新規投稿が失敗' do
      it 'titleが未入力' do
        fill_in 'post_blog[title]', with: nil
        fill_in 'post_blog[blog]', with: 'example'
        click_button '投稿'
        expect(current_path).to eq "/post_blogs"
        expect(page).to have_content "タイトルを入力してください"
      end
      it 'blogが未入力' do
        fill_in 'post_blog[title]', with: 'title'
        fill_in 'post_blog[blog]', with: nil
        click_button '投稿'
        expect(current_path).to eq "/post_blogs"
        expect(page).to have_content "投稿内容を入力してください"
      end
      it 'blogの文字数が201文字以上' do
        fill_in 'post_blog[title]', with: 'title'
        fill_in 'post_blog[blog]', with: Faker::Lorem.characters(number: 201)
        click_button '投稿'
        expect(current_path).to eq "/post_blogs"
        expect(page).to have_content "投稿内容は200文字以内で入力してください"
      end
    end
  end
end