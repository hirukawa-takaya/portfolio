require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "#new" do
    context "as a gest" do
      it "responds successly" do
        get :new
        expect(response).to be_success
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
      
      it "return a 302 response" do
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
      context "with valid attributes"do
        it "adds a user" do
          user_params = FactoryBot.attributes_for(:user)
          expect{
            post :create, params: { user: user_params }
          }.to change(User, :count).by(1)
        end
      end
      
      context "with invalid attributes" do
        it "does not add a project" do
          user_params = FactoryBot.attributes_for(:user, name: nil)
          expect{
            post :create, params: { user: user_params }
          }.to_not change(User, :count)
        end
      end
    end
    
    context "as an authenticated user" do
      before do
        @user = FactoryBot.create(:user)
      end
      
      it "returns a 302 response" do
        log_in @user
        user_params = FactoryBot.attributes_for(:user)
        post :create, params: { user: user_params }
        expect(response).to have_http_status "302"
      end
      
      it "redirects to the top page" do
        log_in @user
          user_params = FactoryBot.attributes_for(:user)
          post :create, params: { user: user_params }
          expect(response).to redirect_to root_path
      end
    end
  end
  
  describe "show" do
    before do
      @user = FactoryBot.create(:user)
    end
    
    it "responds successly" do
      get :show, params: { id: @user.id }
      expect(response).to be_success
    end
    
    it "returns a 200 response" do
      get :show, params: { id: @user.id }
      expect(response).to have_http_status "200"
    end
  end
  
  
  describe "#edit" do
    context "as an authenticated user" do
      before do
        @user = FactoryBot.create(:user)
        @other_user = FactoryBot.create(:user)
      end

      it "responds successly" do
        log_in @user
        get :edit, params: { id: @user.id }
        expect(response).to be_success
      end

      it "returns a 200 response" do
        log_in @user
        get :edit, params: { id: @user.id }
        expect(response).to have_http_status "200"
      end
      
      context "as an unauthorized user" do
        it "redirect_to top pege" do
          log_in @user
          get :edit, params: { id: @other_user.id }
          expect(response).to redirect_to "/"
        end
      end
    
      context "as a gest" do
        it "return a 302 response" do
          get :edit, params: { id: @user.id }
          expect(response).to have_http_status "302" 
        end
          
        it "redirect_to login page" do
          get :edit, params: { id: @user.id }
          expect(response).to redirect_to login_url
        end
      end
    end
  end
  
  describe "#update" do
    context "as an authorized user" do
      before do
        @user = FactoryBot.create(:user)
      end
      
      it "update a user" do
        user_params = FactoryBot.attributes_for(:user, name:"Test")
        log_in @user
        patch :update, params: { id: @user.id, user: user_params }
        expect(@user.reload.name).to eq "Test"
      end
    end
    
    context "as an unauthorized user" do
      before do
        @user = FactoryBot.create(:user)
        @other_user = FactoryBot.create(:user)
      end
      
      it "does not update the project" do
        user_params = FactoryBot.attributes_for(:user, name:"Test2")
        log_in @user
        patch :update, params: { id: @other_user.id, user: user_params }
        expect(@user.reload.name).to eq "hoge"
      end
      
      it "redirect_to top pege" do
        user_params = FactoryBot.attributes_for(:user, name:"Test2")
        log_in @user
        patch :update, params: { id: @other_user.id, user: user_params }
        expect(response).to redirect_to root_path
      end
    end
    
    context "as a gest" do
      before do
        @user = FactoryBot.create(:user)
      end
      it "does not update the user" do
        user_params = FactoryBot.attributes_for(:user, name:"Test")
        patch :update, params: { id: @user.id, user: user_params }
        expect(@user.reload.name).to_not eq "Test"
      end
      
      it "redirects to the top page" do
        user_params = FactoryBot.attributes_for(:user, name:"Test")
        patch :update, params: { id: @user.id, user: user_params }
        expect(response).to redirect_to login_path
      end
    end
  end
end
