require 'rails_helper'

RSpec.feature "Topics", type: :feature do
  
  scenario "user creates a new topic(description, image)", js: true do
    user = FactoryBot.create(:user)
    visit root_path
    find("#login").click
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログイン"
    
    expect {
      visit new_topic_path
      fill_in "topic_description", with: "test"
      attach_file "topic[image]", "tmp/02.jpg"
      click_button "投稿"
      
      expect(page).to have_content "投稿しました"
      expect(page).to have_content "test"
      expect(page).to have_content "#{user.name}"
    }.to change(user.topics, :count).by(1)
  end
  
  scenario "user destroys a topic" do
    user = FactoryBot.create(:user)
    visit root_path
    find("#login").click
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログイン"
    
    expect{
      visit new_topic_path
      fill_in "topic_description", with: "test"
      click_button "投稿"
      click_link "test"
      click_link "削除"
    }.to_not change(user.topics, :count)
  end
  
  scenario "user can set a password by manually" do
    user = FactoryBot.create(:user)
    visit root_path
    find("#login").click
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログイン"
    
    visit new_topic_path
    fill_in "投稿内容(必須)", with: "test"
    fill_in "topic[password]", with: "password"
    click_button "投稿"
    click_link "secret"
    fill_in "topic_password", with: "password"
    click_button "送信"
    expect(page).to have_content "成功"
  end
  
  scenario "user can create password　by Automatic generation" do
    user = FactoryBot.create(:user)
    visit root_path
    find("#login").click
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログイン"
    
    expect{
      visit new_topic_path
      fill_in "投稿内容(必須)", with: "test"
      click_on "パスワードを生成する"
      click_button "投稿"
    }.to change(user.topics, :count).by(1)
  end
  
end
