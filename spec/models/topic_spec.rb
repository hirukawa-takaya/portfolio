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
    #descriptionなしの場合はinvalid
    #255文字以上の場合invalid
  end
  
  describe "#image_path" do
    #画像なしvalid
  end
  
  describe "#password" do
    #passweordなしvalid
  end
end