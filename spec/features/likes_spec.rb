require 'rails_helper'

RSpec.feature "Likes", type: :feature do
  # scenario "user can like" , js: true do
  #   user = FactoryBot.create(:user)
  #   visit root_path
  #   click_link "ログイン"
  #   fill_in "Email", with: user.email
  #   fill_in "Password", with: user.password
  #   click_button "ログイン"
    
  #   visit new_topic_path
  #   fill_in "topic_description", with: "test"
  #   click_button "投稿"
    
  #   expect{
  #     click_button ".like-btn"
  #   }.to change(user.likes, :count).by(1)
  # end
end