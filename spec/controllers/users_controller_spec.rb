require 'rails_helper'

RSpec.describe UsersController, type: :controller do
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
      
      it "redirect_to top pege" do
        log_in @user
        get :edit, params: { id: @other_user.id }
        expect(response).to redirect_to "/"
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
end
