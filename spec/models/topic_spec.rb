require 'rails_helper'

RSpec.describe Topic, type: :model do
  
  it "is valid with :description, :password" do
    topic = FactoryBot.build(:topic)
    expect(topic).to be_valid
  end
  
  describe "#description" do
    it "is invalid without a description" do
      topic = FactoryBot.build(:topic, description: nil)
      topic.valid?
      expect(topic.errors.messages[:description]).to include("を入力してください")
    end
    
    it "is invalid that has more than 256" do
      topic = FactoryBot.build(:topic, description: "a" * 256)
      topic.valid?
      expect(topic.errors[:description]).to include("は255文字以内で入力してください")
    end
    
  end
  
end