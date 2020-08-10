require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  before do
  end
  
  describe "#new" do
    context "as s gest" do
      it "responds successly" do
        get :new
        expect(response).to be_successful
      end
      
      it "returns a 200 response" do
        get :new
        expect(response).to have_http_status "200"
      end
    end
    
    context "as a log_in user" do
      before do
        @user = FactoryBot.create(:user)
      end
    
      it "returns a 302 response" do
        log_in @user
        get :new
        expect(response).to have_http_status "302"
      end
      
      it "redirect_to top page" do
        log_in @user
        get :new
        expect(response).to redirect_to root_path
      end
    end
  end
  
  describe "#create" do
    context "as a gest" do
      context "with valid attributes" do
        it "adds a user" do
        end
      end
      context "with invalid attributes" do
        it "does not add a project" do
        end
      end
    end
    
    context "as an authenticated user" do
    end
  end
  
  describe "#destroy" do
    context "as an authenticated user" do
    end
    
    context "as a gest" do
    end
  end
end
