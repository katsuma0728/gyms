# frozen_string_literal: true

require 'rails_helper'

describe 'user新規登録のテスト' do
  before do
    visit new_user_registration_path
  end
  context 'フォームの入力値が正常' do
    it 'userの新規作成が成功' do
      fill_in 'user[name]', with: 'user'
      fill_in 'user[introduction]', with: 'example'
      fill_in 'user[email]', with: 'user@example.com'
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
      click_button '新規登録'
      expect(current_path).to eq current_path
      expect(page).to have_content 'アカウント登録が完了しました'
    end
  end
  context '名前が未記入' do
    it 'userの新規作成が失敗' do
      fill_in 'user[name]', with: nil
      fill_in 'user[introduction]', with: 'example'
      fill_in 'user[email]', with: 'user@example.com'
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
      click_button '新規登録'
      expect(current_path).to eq new_user_registration_path
      expect(page).to have_content '名前を入力してください'
    end
  end
  context '同じ名前が登録済み' do
    it 'userの新規作成が失敗' do
      fill_in 'user[name]', with: user.name
      fill_in 'user[introduction]', with: 'example'
      fill_in 'user[email]', with: 'user@example.com'
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
      click_button '新規登録'
      expect(current_path).to eq new_user_registration_path
      expect(page).to have_content '名前はすでに存在します'
    end
  end
  context '名前が21文字以上' do
    it 'userの新規作成が失敗' do
      fill_in 'user[name]', with: 'testtesttesttesttest1'
      fill_in 'user[introduction]', with: 'example'
      fill_in 'user[email]', with: 'person@example.com'
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
      click_button '新規登録'
      expect(current_path).to eq new_user_registration_path
      expect(page).to have_content '名前は20文字以内で入力してください'
    end
  end
  context '目標が未記入' do
    it 'userの新規作成が失敗' do
      fill_in 'user[name]', with: 'user'
      fill_in 'user[introduction]', with: nil
      fill_in 'user[email]', with: 'user@example.com'
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
      click_button '新規登録'
      expect(current_path).to eq new_user_registration_path
      expect(page).to have_content '目標を入力してください'
    end
  end
  context 'メールアドレス未記入' do
    it 'customerの新規作成が失敗' do
      fill_in 'user[name]', with: 'user'
      fill_in 'user[introduction]', with: 'example'
      fill_in 'user[email]', with: nil
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
      click_button '新規登録'
      expect(current_path).to eq new_user_registration_path
      expect(page).to have_content 'メールアドレスを入力してください'
    end
  end
  context '登録済メールアドレス' do
    it 'userの新規作成が失敗' do
      fill_in 'user[name]', with: 'user'
      fill_in 'user[introduction]', with: 'example'
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
      click_button '新規登録'
      expect(current_path).to eq new_user_registration_path
      expect(page).to have_content 'メールアドレスはすでに存在します'
    end
  end
end