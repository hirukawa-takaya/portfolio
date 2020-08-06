require 'rails_helper'

RSpec.describe Comment, type: :model do
  it "is valid with :content" do
    comment = FactoryBot.build(:comment)
    expect(comment).to be_valid
  end
  
  describe "#content" do
    it "is invalid without a content" do
      comment = FactoryBot.build(:comment, content: nil)
      comment.valid?
      expect(comment.errors.messages[:content]).to include("を入力してください")
    end
    
    it "is invalid that has more than 225" do
      comment = FactoryBot.build(:comment, content: "a" * 226)
      comment.valid?
      expect(comment.errors.messages[:content]).to include("は225文字以内で入力してください")
    end
    
  end
  
end
