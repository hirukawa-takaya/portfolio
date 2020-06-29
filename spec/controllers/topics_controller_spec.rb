require 'rails_helper'

RSpec.describe TopicsController, type: :controller do
  describe "#index" do
    it "responds successfully" do
      get :index
      expect(response).to be_success
    end
  end
  
  describe "#create" do
    before do
      @user = FactoryBot.create(:user)
    end
    
    it "adds a topic" do
      topic_params = FactoryBot.attributes_for(:topic)
      log_in @user
      expect{ post :create, params: {topic: topic_params}
      }.to change(@user.topics, :count).by(1)
    end
  end

end
