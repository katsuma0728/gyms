# frozen_string_literal: true

require 'rails_helper'

describe 'スケジュール機能のテスト' do
  let!(:user) { create(:user, id: 1, name: 'test_user', birth_date: Time.now, introduction: 'test', email: 'test@email.com', password: 'password') }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
    expect(current_path).to eq user_path(id:1)
  end

  describe 'スケジュール新規登録のテスト' do
    before do
        visit schedules_path
    end
    context 'フォームの入力の確認' do
      it '入力が正常' do
        fill_in 'schedule[title]', with: 'title'
        fill_in 'schedule[memo]', with: 'example'
        find("#schedule_start_time_1i").find("option[value='2023']").select_option
        find("#schedule_start_time_2i").find("option[value='7']").select_option
        find("#schedule_start_time_3i").find("option[value='9']").select_option
        find("#schedule_start_time_4i").find("option[value='14']").select_option
        find("#schedule_start_time_5i").find("option[value='08']").select_option
        click_button '登録'
        expect(current_path).to eq schedules_path
        expect(page).to have_content "カレンダーに新規登録しました"
      end
      it '種目が未入力' do
        fill_in 'schedule[title]', with: nil
        fill_in 'schedule[memo]', with: 'example'
        find("#schedule_start_time_1i").find("option[value='2023']").select_option
        find("#schedule_start_time_2i").find("option[value='7']").select_option
        find("#schedule_start_time_3i").find("option[value='9']").select_option
        find("#schedule_start_time_4i").find("option[value='14']").select_option
        find("#schedule_start_time_5i").find("option[value='08']").select_option
        click_button '登録'
        expect(current_path).to eq "/schedules"
        expect(page).to have_content "種目を入力してください"
      end
      it 'titleの文字数が21文字以上' do
        fill_in 'schedule[title]', with: Faker::Lorem.characters(number: 21)
        fill_in 'schedule[memo]', with: 'example'
        find("#schedule_start_time_1i").find("option[value='2023']").select_option
        find("#schedule_start_time_2i").find("option[value='7']").select_option
        find("#schedule_start_time_3i").find("option[value='9']").select_option
        find("#schedule_start_time_4i").find("option[value='14']").select_option
        find("#schedule_start_time_5i").find("option[value='08']").select_option
        click_button '登録'
        expect(current_path).to eq "/schedules"
        expect(page).to have_content "種目は20文字以内で入力してください"
      end
      it 'memoの文字数が201文字以上' do
        fill_in 'schedule[title]', with: 'title'
        fill_in 'schedule[memo]', with: Faker::Lorem.characters(number: 201)
        find("#schedule_start_time_1i").find("option[value='2023']").select_option
        find("#schedule_start_time_2i").find("option[value='7']").select_option
        find("#schedule_start_time_3i").find("option[value='9']").select_option
        find("#schedule_start_time_4i").find("option[value='14']").select_option
        find("#schedule_start_time_5i").find("option[value='08']").select_option
        click_button '登録'
        expect(current_path).to eq "/schedules"
        expect(page).to have_content "メモは200文字以内で入力してください"
      end
    end
  end

  describe 'スケジュール詳細画面のテスト' do
    let!(:schedule) { create(:schedule, id: 1, user_id: user.id, title: 'title', memo: 'memo') }

    before do
      visit schedule_path(id: 1)
    end

    context '詳細画面表示の確認' do
      it '種目、メモ、編集、削除ボタンが表示されている' do
        expect(page).to have_content schedule.title
        expect(page).to have_content schedule.memo
        expect(page).to have_link href: edit_schedule_path(1)
        expect(page).to have_link href: schedule_path(1)
      end
      it 'スケジュールの削除' do
        expect { find_link(href: schedule_path(1)).click }.to change { Schedule.count }.by(-1)
        expect(current_path).to eq schedules_path
      end
    end
  end

  describe '編集画面のテスト' do
    let!(:schedule) { create(:schedule, id: 1, user_id: user.id, title: 'title', memo: 'memo') }

    before do
      visit edit_schedule_path(id: 1)
    end

    context '編集機能の確認' do
      it '種目、メモを更新' do
        fill_in 'schedule[title]', with: 'title2'
        fill_in 'schedule[memo]', with: 'memo2'
        find("#schedule_start_time_1i").find("option[value='2023']").select_option
        find("#schedule_start_time_2i").find("option[value='7']").select_option
        find("#schedule_start_time_3i").find("option[value='9']").select_option
        find("#schedule_start_time_4i").find("option[value='14']").select_option
        find("#schedule_start_time_5i").find("option[value='08']").select_option
        click_button '変更'
        expect(current_path).to eq schedules_path
        expect(page).to have_content "カレンダーを更新しました"
        expect(page).to have_content "title2"
        visit edit_schedule_path(id: 1)
        expect(page).to have_content "memo2"
      end
    end
  end
end
