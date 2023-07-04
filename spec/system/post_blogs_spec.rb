# frozen_string_literal: true

require 'rails_helper'

describe '投稿画面のテスト' do
  describe 'トップ画面(root_path)のテスト' do
    before do 
      visit root_path
    end
    context '表示の確認' do
      it 'トップ画面(root_path)に新規投稿ページと投稿一覧ページへのリンクが表示されているか' do
        expect(page).to have_link "", href: new_post_blog_path
        expect(page).to have_link "", href: post_blogs_path
      end
      it 'root_pathが"/"であるか' do
        expect(current_path).to eq('/')
      end
    end
  end
  descrive '新規投稿画面のテスト'　do
    before do 
      visit new_post_blog_path
    end
    context '入力フォーム、下書き一覧へのリンク、投稿ボタンが表示されているか' do
      expect(page).to have_field 'post_blog[image]'
      expect(page).to have_field 'post_blog[title]'
      expect(page).to have_field 'post_blog[blog]'
      expect(page).to have_field 'post_blog[name]'
      expect(page).to have_field 'post_blog[status]'
      expect(page).to have_link "", href: confirm_post_blogs_path
      expect(page).to have_button 'Create PostBlog'
    end
    context '投稿処理に関するテスト' do
      it '投稿に成功しフラッシュメッセージが表示されるか' do
        fill_in 'post_blog[title]', with: Faker::Lorem.characters(number:5)
        fill_in 'post_blog[blog]', with: Faker::Lorem.characters(number:20)
        click_button 'Create PostBlog'
        expect(page).to have_content '新規投稿しました'
      end
      it '投稿に失敗する' do
        click_button 'Create PostBlog'
        expect(page).to have_content 'error'
        expect(current_path).to eq('/new_post_blog_path')
      end
      it '投稿後のリダイレクト先は正しいか' do
        fill_in 'post_blog[title]', with: Faker::Lorem.characters(number:5)
        fill_in 'post_blog[body]', with: Faker::Lorem.characters(number:20)
        click_button 'Create PostBlog'
        expect(page).to have_current_path post_blogs_path
      end
    end
  end
  describe "一覧画面のテスト" do
    before do
      visit post_blogs_path
    end
    context '一覧の表示とリンクの確認' do
      it "post_blogの一覧表示(card)と検索フォーム、検索タグが同一画面に表示されているか" do
        expect(page).to have_selector 'card'
        expect(page).to have_field 'post_blog[keyword]'
        expect(page).to have_link ' search_tag_post_blogs_path'
      end
      it "post_blogのタイトルと投稿内容を表示し、投稿詳細のリンクが表示されているか" do
        (1..5).each do |i|
          PostBlog.create(title:'hoge'+i.to_s,body:'body'+i.to_s)
        end
        visit post_blogs_path
        PostBlog.all.each_with_index do |post_blog, i|
          j = i * 3
          expect(page).to have_content post_blog.title
          expect(page).to have_content post_blog.body
          # Showリンク
          show_link = find_all('a')[j]
          expect(show_link.native.inner_text).to match(/show/i)
          expect(show_link[:href]).to eq post_blog_path(post_blog)
        end
      end
    end
  end
  describe '詳細画面のテスト' do
    before do
      visit post_blog_path(post_blog)
    end
    context '表示の確認' do
      it '投稿のタイトルと投稿内容が画面に表示されていること' do
        expect(page).to have_content post_blog.title
        expect(page).to have_content post_blog.blog
      end
      it 'Editリンクが表示される' do
        edit_link = find_all('a')[0]
        expect(edit_link.native.inner_text).to match(/edit/i)
  		end
    end
    context 'リンクの遷移先の確認' do
      it 'Editの遷移先は編集画面か' do
        edit_link = find_all('a')[0]
        edit_link.click
        expect(current_path).to eq('/post_blog/' + post_blog.id.to_s + '/edit')
      end
    end
  end
  describe '編集画面のテスト' do
    before do
      visit edit_post_blog_path(post_blog)
    end
    context '表示の確認' do
      it '編集前の情報がフォームに表示(セット)されている' do
        expect(page).to have_field 'post_blog[image]', with: post_blog.image
        expect(page).to have_field 'post_blog[title]', with: post_blog.title
        expect(page).to have_field 'post_blog[body]', with: post_blog.body
        expect(page).to have_field 'post_blog[name]', with: post_blog.tags.name
        expect(page).to have_field 'post_blog[status]', with: post_blog.status
      end
      it 'Update Bookボタンが表示される' do
        expect(page).to have_button 'Update PostBlog'
      end
    end
    context '更新処理に関するテスト' do
      it '更新に成功しサクセスメッセージが表示されるか' do
        fill_in 'post_blog[title]', with: Faker::Lorem.characters(number:5)
        fill_in 'post_blog[body]', with: Faker::Lorem.characters(number:20)
        click_button 'Update PostBlog'
        expect(page).to have_content '投稿を更新しました'
      end
      it '更新に失敗しエラーメッセージが表示されるか' do
        fill_in 'post_blog[title]', with: ""
        fill_in 'post_blog[body]', with: ""
        click_button 'Update PostBlog'
        expect(page).to have_content 'error'
      end
      it '更新後のリダイレクト先は正しいか' do
        fill_in 'post_blog[title]', with: Faker::Lorem.characters(number:5)
        fill_in 'post_blog[body]', with: Faker::Lorem.characters(number:20)
        click_button 'Update PostBlog'
        expect(page).to have_current_path post_blogs
      end
    end
  end
end