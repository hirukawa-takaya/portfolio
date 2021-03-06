require 'rails_helper'

RSpec.feature "Likes", type: :feature do
  scenario "user can like" , js: true do
    user = FactoryBot.create(:user)
    visit root_path
    find("#login").click
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログイン"
    
    visit new_topic_path
    fill_in "topic_description", with: "test"
    click_button "投稿"
    
    expect{
      page.all(".like-btn")[1].click
    }.to change(user.likes, :count).by(1)
  end
  
  scenario "user can destroy like" , js: true do
    user = FactoryBot.create(:user)
    visit root_path
    find("#login").click
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログイン"
    
    visit new_topic_path
    fill_in "topic_description", with: "test"
    click_button "投稿"
    
    page.all(".like-btn")[1].click
    expect{
      find(".unlike-btn").click
    }.to change(user.likes, :count).by(-1)
  end
  
end