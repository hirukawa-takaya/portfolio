require 'rails_helper'

RSpec.feature "Topics", type: :feature do
  scenario "user creates a new topic" do
    user = FactoryBot.create(:user)
    visit root_path
    click_link "ログイン"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_link "ログイン"
    
    expect {
      visit new_topic_path
      fill_in "description(必須)", with: "test"
      click_button "投稿"
      
      expect(page).to have_content "投稿しました"
      expect(page).to have_content "test"
      expect(page).to have_content "Owner: #{user.name}"
    }.to change(user.topics, :count).by(1)
  end
end
