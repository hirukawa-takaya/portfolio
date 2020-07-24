require 'rails_helper'

RSpec.feature "Topics", type: :feature do
  
  scenario "user can login" do
    user = FactoryBot.create(:user)
    visit root_path
    click_link "ログイン"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "ログイン"
    expect(page).to have_content 'ログインに成功しました'
  end
  
  scenario "user creates a new topic" do
    user = FactoryBot.create(:user)
    visit root_path
    click_link "ログイン"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "ログイン"
    
    expect {
      visit new_topic_path
      fill_in "topic_description", with: "test"
      click_button "投稿"
      
      expect(page).to have_content "投稿しました"
      expect(page).to have_content "test"
      expect(page).to have_content "#{user.name}"
    }.to change(user.topics, :count).by(1)
  end
  
  scenario "user destroys a topic" do
    user = FactoryBot.create(:user)
    visit root_path
    click_link "ログイン"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "ログイン"
    
    expect{
      visit new_topic_path
      fill_in "topic_description", with: "test"
      click_button "投稿"
      click_link "test"
      click_link "削除"
    }.to_not change(user.topics, :count)
  end
  
  # scenario "user comments a topic" do
  #   user = FactoryBot.create(:user)
  #   visit root_path
  #   click_link "ログイン"
  #   fill_in "Email", with: user.email
  #   fill_in "Password", with: user.password
  #   click_button "ログイン"
    
  #   expect{
  #     visit new_topic_path
  #     fill_in "topic_description", with: "test"
  #     click_button "投稿"
  #     click_link "test"
  #     fill_in "comment_content", with: "comment"
  #     click_button "コメントする"
  #   }.to change(user.comments, :count).by(1)
  # end
  
end
