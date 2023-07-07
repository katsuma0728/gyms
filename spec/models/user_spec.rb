# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Userモデルのテスト', type: :model do
  let!(:user) { create(:user) }
  let(:other_user) { create(:user) }

  describe 'バリデーションのテスト' do

    context 'nameカラム' do
      it '空欄でないこと' do
        user.name = ''
        expect(user.valid?).to eq false
      end
      it '20文字以下であること: 20文字は〇' do
        user.name = Faker::Lorem.characters(number: 20)
        expect(user.valid?).to eq true
      end
      it '20文字以下であること: 21文字は×' do
        user.name = Faker::Lorem.characters(number: 21)
        expect(user.valid?).to eq false
      end
      it '一意性があること' do
        user.name = other_user.name
        expect(user.valid?).to eq false
      end
    end

    context 'introductionカラム' do
        it '空欄でないこと' do
          user.introduction = ''
           expect(user.valid?).to eq false
        end
      end

    context 'emailカラム' do
      it '空欄でないこと' do
        user.email = ''
        expect(user.valid?).to eq false
      end
      it '一意性があること' do
        user.email = other_user.email
        expect(user.valid?).to eq false
      end
    end
  end
end