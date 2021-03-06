require 'rails_helper'

RSpec.describe TopicsController, type: :controller do
  describe "#new" do
    context "as an authenticated user" do
      before do
        @user = FactoryBot.create(:user)
      end
      
      it "responds successfully" do
        log_in @user
        get :new
        expect(response).to be_successful
      end
      
      it "returns a 200 response" do
        log_in @user
        get :new
        expect(response).to have_http_status "200"
      end
      
      context "as a gest" do
        it "returns a 302 response" do
          get :new
          expect(response).to have_http_status "302"
        end
        
        it "redirects to log_in page" do
          get :new
          expect(response).to redirect_to login_url
        end
      end
    end
  end
  
  describe "#index" do
    before do
      @user = FactoryBot.create(:user)
    end
    
    it "responds successfully" do
      get :index
      expect(response).to be_successful
    end
    
    it "returns a 200 response" do
      log_in @user
      get :index
      expect(response).to have_http_status "200"
    end
  end
  
  describe "#create" do
    context "as an authenticated user" do
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
    
    context "as a gest" do
      it "returns a 302 response" do
        topic_params = FactoryBot.attributes_for(:topic)
        post :create, params: {topic: topic_params}
        expect(response).to have_http_status "302"
      end
      
      it "redirects to the log_in page" do
        topic_params = FactoryBot.attributes_for(:topic)
        post :create, params: {topic: topic_params}
        expect(response).to redirect_to "/login"
      end
    end
  end
  
  describe "#topic_password" do
    context "with password" do
      before do
        @topic = FactoryBot.create(:topic)
      end
      it "responds successfully" do
        get :topic_password, params: { id: @topic.id }
        expect(response).to be_successful
      end
      
      it "returns a 200 response" do
        get :topic_password, params: { id: @topic.id }
        expect(response).to have_http_status "200"
      end
    end
    
    context "without password" do
      before do
        @topic = FactoryBot.create(:topic, :without_password)
      end
      
      it "returns a 302 response" do
        get :topic_password, params: { id: @topic.id }
        expect(response).to have_http_status "302"
      end
      
      it "redirects to log_in page" do
         get :topic_password, params: { id: @topic.id }
        expect(response).to redirect_to topics_path
      end
    end
  end
  
  describe "#show" do
    before do
      @topic = FactoryBot.create(:topic, :without_password)
    end
    
    describe "without a password" do
      it "responds successfully" do
        get :show, params: { id: @topic.id }
          expect(response).to be_successful
        end
      
      it "returns a 200 response" do
        get :show, params: { id: @topic.id }
          expect(response).to have_http_status "200"
      end
    end
    
    describe "with password" do
      before do
        @topic = FactoryBot.create(:topic)
      end
      it "redirect to topic_password" do
        get :show, params: { id: @topic.id }
          expect(response).to redirect_to "/topic_password/#{@topic.id}"
      end
    end
    
  end
  
  describe "#destroy" do
    context "as an authorized user" do
      before do
        @topic = FactoryBot.create(:topic)
      end
      
      it "deletes a topic" do
        log_in @topic.user
        expect{
          delete :destroy, params: { id: @topic.id }
        }.to change(Topic, :count).by(-1)
      end
    end
    
    context "as an unauthorized user" do
      before do
        @topic = FactoryBot.create(:topic)
        @other_topic = FactoryBot.create(:topic, :other_topic)
      end
      it "does not delete the topic" do
        log_in @topic.user
        expect{
        delete :destroy, params: { id: @other_topic.id }
        }.to_not change(Topic, :count)
      end
      
      it "redirects to the index" do
        log_in @topic.user
        delete :destroy, params: { id: @other_topic.id }
        expect(response).to redirect_to root_path
      end
    end
    
    context "as a gest" do
      before do
        @topic = FactoryBot.create(:topic)
      end
      
      it "does not delete the topic" do
        expect{
          delete :destroy, params: { id: @topic.id }
        }.to_not change(Topic, :count)
      end
      
      it "redirects to the log-in page" do
        delete :destroy, params: { id: @topic.id }
        expect(response).to redirect_to login_path
      end
      
    end
  end

end
