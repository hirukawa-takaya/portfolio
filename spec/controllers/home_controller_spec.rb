require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe "#top" do
    it "responsed successfully" do
      get :top
      expect(response).to be_successful
    end
    
    it "returns a 200resuponse" do
      get :top
      expect(response).to have_http_status "200"
    end
  end

end
