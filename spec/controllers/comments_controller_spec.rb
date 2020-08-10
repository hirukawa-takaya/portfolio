require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe "#create" do
    before do
      @comment = FactoryBot.create(:comment)
    end
      
    context "as an authorized user" do
      it "comment a topic" do
        @comment_params = FactoryBot.attributes_for(:comment)
        log_in @comment.user
        expect{ post :create, xhr: true, params: {id: @comment.id, topic_id: @comment.topic, comment: @comment_params}
        }.to change(Comment, :count).by(1)
      end
    end
    
    context "as a gest" do
      it "does not comment a topic" do
        @comment_params = FactoryBot.attributes_for(:comment)
        expect{ post :create, xhr: true, params: {id: @comment.id, topic_id: @comment.topic, comment: @comment_params}
        }.to_not change(Comment, :count)
      end
    end
  end
    
  describe "#destroy" do
    before do
        @comment = FactoryBot.create(:comment)
    end
    
    context "as an authorized user" do
      it "delete a comment" do
        log_in @comment.user
        expect{ delete :destroy, xhr: true, params: {id: @comment.id, topic_id: @comment.topic}
        }.to change(Comment, :count).by(-1)
      end
    end
    
    context "as a gest" do
      it "does not delete a comment" do
        expect{ delete :destroy, xhr: true, params: {id: @comment.id, topic_id: @comment.topic}
        }.to_not change(Comment, :count)
      end
    end
  end
end