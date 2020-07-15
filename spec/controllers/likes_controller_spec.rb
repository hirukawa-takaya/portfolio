require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  describe "#create" do
    context "as an authenticated user" do
      before do
        @user = FactoryBot.create(:user)
      end
      it "adds a like" do
        # like_params = FactoryBot.attributes_for(:like)
        # log_in @user
        # expect{ post :create, params: {like: like_params}
        # }.to change(@user.likes, :count).by(1)
      end
    end
    
    context "as a gest" do
    end
  end
  
  describe "#destroy" do
    context "as an authenticated user" do
      before do
        @user = FactoryBot.create(:user)
      end
      
      it "" do
      end
    end
    
    context "as a gest" do
    end
  end
end
