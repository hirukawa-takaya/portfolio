require 'rails_helper'

RSpec.feature "Comment", type: :feature do
  scenario "user can comment" , js: true do
    user = FactoryBot.create(:user)
    visit root_path
    find("#login").click
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログイン"
    
    visit new_topic_path
    fill_in "topic_description", with: "test"
    click_button "投稿"
    
    click_link "test"
    fill_in "comment[content]", with: "test comment"
    click_button "コメントする"
    expect(page).to have_content "test comment"
  end
  
  scenario "user can destroy comment" , js: true do
    user = FactoryBot.create(:user)
    visit root_path
    find("#login").click
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログイン"
    
    visit new_topic_path
    fill_in "topic_description", with: "test"
    click_button "投稿"
    
    click_link "test"
    fill_in "comment[content]", with: "destroy comment"
    click_button "コメントする"
    expect{
      find(".destroy-comment").click
    }.to change(user.comments, :count).by(-1)
  end  
  
end