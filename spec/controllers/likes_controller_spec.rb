require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  
  describe "#create" do
    context "as an authorized user" do
      before do
        @like = FactoryBot.create(:like)
      end
      it "like a topic" do
        log_in @like.user
        expect{ post :create, xhr: true, params: {id: @like.id, topic_id: @like.topic}
        }.to change(Like, :count).by(1)
      end
    
    context "as a gest" do
      it "does not like a topic" do
        expect{ post :create, xhr: true, params: {id: @like.id, topic_id: @like.topic}
        }.to_not change(Like, :count)
      end
    end
  end
    
  end
  
  describe "#destroy" do
    context "as an authorized user" do
      
      before do
        @like = FactoryBot.create(:like)
      end
      
      it "delete a like" do
        log_in @like.user
        expect{ delete :destroy, xhr: true, params: {id: @like.id, topic_id: @like.topic}
        }.to change(Like, :count).by(-1)
      end
    
    context "as a gest" do
      it "does not delete a topic" do
        expect{ delete :destroy, xhr: true, params: {id: @like.id, topic_id: @like.topic}
        }.to_not change(Like, :count)
      end
    end
  end
end
  
end