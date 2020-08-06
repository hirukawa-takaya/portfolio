require 'rails_helper'

RSpec.feature "Users", type: :feature do
  
  scenario "user can create acount" do
    visit root_path
    find("#signup").click
    fill_in "名前",with: "test"
    fill_in "メールアドレス", with: "test@test.test"
    fill_in "パスワード", with: "password"
    click_button "登録"
    expect(page).to have_content "新規登録しました"
  end
  
  scenario "user can login & edit & logout" do
    user = FactoryBot.create(:user)
    visit root_path
    find("#login").click
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログイン"
    expect(page).to have_content 'ログインしました'
    
    click_link "設定"
    fill_in "名前", with: "test_edit"
    fill_in "メールアドレス", with: "test@sdit.com"
    fill_in "パスワード", with: "test_edit"
    fill_in "パスワードの再確認", with: "test_edit"
    click_button "更新"
    expect(page).to have_content 'ユーザー情報を更新しました'
    
    click_link "ログアウト"
    expect(page).to have_content 'ログアウトしました'
  end
  
  
  
end