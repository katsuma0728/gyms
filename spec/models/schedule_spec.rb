# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Scheduleモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do

    let(:user) { create(:user) }
    let!(:schedule) { build(:schedule, user_id: user.id) }

    context 'titleカラム' do
      it '空欄でないこと' do
        schedule.title = ''
        expect(schedule.valid?).to eq false
      end
      it '20文字以下であること: 20文字は〇' do
        schedule.title = Faker::Lorem.characters(number: 20)
        expect(schedule.valid?).to eq true
      end
      it '20文字以下であること: 21文字は×' do
        schedule.title = Faker::Lorem.characters(number: 21)
        expect(schedule.valid?).to eq false
      end
    end

    context 'memoカラム' do
      it '200文字以下であること: 200文字は〇' do
        schedule.memo = Faker::Lorem.characters(number: 200)
        expect(schedule.valid?).to eq true
      end
      it '200文字以下であること: 201文字は×' do
        schedule.memo = Faker::Lorem.characters(number: 201)
        expect(schedule.valid?).to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do

    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Schedule.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end