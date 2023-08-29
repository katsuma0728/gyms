# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Userモデルのテスト", type: :model do
  describe "バリデーションのテスト" do
    let!(:other_user) { create(:user) }
    let(:user) { build(:user) }

    context "nameカラム" do
      it "空欄でないこと" do
        user.name = ""
        expect(user.valid?).to eq false
      end
      it "20文字以下であること: 20文字は〇" do
        user.name = Faker::Lorem.characters(number: 20)
        expect(user.valid?).to eq true
      end
      it "20文字以下であること: 21文字は×" do
        user.name = Faker::Lorem.characters(number: 21)
        expect(user.valid?).to eq false
      end
      it "一意性があること" do
        user.name = other_user.name
        expect(user.valid?).to eq false
      end
    end

    context "introductionカラム" do
        it "空欄でないこと" do
          user.introduction = ""
          expect(user.valid?).to eq false
        end
      end

    context "emailカラム" do
      it "空欄でないこと" do
        user.email = ""
        expect(user.valid?).to eq false
      end
      it "一意性があること" do
        user.email = other_user.email
        expect(user.valid?).to eq false
      end
    end
  end

  describe "アソシエーションのテスト" do
    context "PostBlogモデルとの関係" do
      it "1:Nとなっている" do
        expect(User.reflect_on_association(:post_blogs).macro).to eq :has_many
      end
    end

    context "Scheduleモデルとの関係" do
      it "1:Nとなっている" do
        expect(User.reflect_on_association(:schedules).macro).to eq :has_many
      end
    end
  end
end
