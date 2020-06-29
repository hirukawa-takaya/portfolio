require 'rails_helper'

RSpec.describe User, type: :model do
  
  it "is valid with name, email, password, password_confirmation" do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end
  
  describe "#name" do
    it "is invalid without a name" do
      user = FactoryBot.build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to include("を入力してください")
    end
    
    it "is invalid that has more than 31" do
      user = FactoryBot.build(:user, name: "a" * 31)
      user.valid?
      expect(user.errors[:name]).to include("は30文字以内で入力してください")
    end
  end
  
  describe "#email" do
    it "is invalid without a email" do
      user = FactoryBot.build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("は不正な値です")
    end
    
    it "is invalid a blank" do
      user = FactoryBot.build(:user, email: "      ")
      user.valid?
      expect(user.errors[:email]).to include("を入力してください", "は不正な値です")
    end
    
    it "is invalid that has more than 256" do
      user = FactoryBot.build(:user, email: "a" * 244 + "@example.com")
      user.valid?
      expect(user.errors[:email]).to include("は255文字以内で入力してください")
    end
    
    it "is valid that accept valid addresses" do
      valid_email = %w[hoge@example.com HOGE@example.com h_o-ge@exam.ple.com
                       ho.ge@example.com ho+ge@example.com]
      valid_email.each do |valid_email|
        user = FactoryBot.build(:user, email: valid_email)
        user.valid?
        expect(user).to be_valid
      end
    end
  end
  
  describe "#password" do
    it "is invalid a blank" do
      user = FactoryBot.build(:user, password: "      ")
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end
    
    it "is invalid that has less than 5" do
      user = FactoryBot.build(:user, password: "aaaaa")
      user.valid?
      expect(user.errors[:password]).to include("は6文字以上で入力してください")
    end
    
  end
  
end
