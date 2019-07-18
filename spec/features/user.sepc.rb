# 「FactoryBotを使用します」という記述
FactoryBot.define do

  factory :user do
    name { 'test_user_01' }
    email { 'hoge@hoge.com' }
    password { '123456' }
    password_confirmation { '123456' }
  end

  factory :second_user,class: User do
    name { 'test_task_02' }
    email { 'fuga@fuga.com' }
    password { '123456' }
    password_confirmation { '123456' }
  end
end

# このrequireで、Capybaraなどの、Feature Specに必要な機能を使用可能な状態にしています
require 'rails_helper'

# このRSpec.featureの右側に、「タスク管理機能」のように、テスト項目の名称を書きます（do ~ endでグループ化されています）
RSpec.feature "ユーザー登録機能", type: :feature do
  background do
    # あらかじめタスク一覧のテストで使用するためのタスクを二つ作成する
    FactoryBot.create(:user)
    FactoryBot.create(:second_user)
  end

  scenario "ユーザー登録後、そのままログインユーザーのマイページに遷移できるかのテスト" do
    visit sessions_new_path

    click_on 'Sign up'
    fill_in 'user_name', with: 'abababa'
    fill_in 'user_email', with: 'aaa@abc.com'
    fill_in 'user_password', with: '123456'
    fill_in 'user_password_confirmation', with: '123456'
    click_on 'commit'
    expect(page).to have_content 'abababa'
    expect(page).to_not have_content 'taaa@abc.com'
  end

  scenario "登録ユーザーでログインできるかのテスト" do
    visit new_session_path

    fill_in 'session_email', with: 'hoge@hoge.com'
    fill_in 'session_password', with: '123456'
    click_on 'commit'
    
    expect(page).to have_content 'test_user_01'
    expect(page).to have_content 'hoge@hoge.com'
  end

  scenario "マイページにログインユーザー以外の情報が表示されていないかのテスト" do
    visit new_session_path

    fill_in 'session_email', with: 'hoge@hoge.com'
    fill_in 'session_password', with: '123456'
    click_on 'commit'
    expect(page).to_not have_content 'test_user_02'
    expect(page).to_not have_content 'fuga@fuga.com'
  end

  scenario "ログイン中は新規ユーザー登録画面に画面遷移できないかのテスト" do
    visit new_session_path

    fill_in 'session_email', with: 'hoge@hoge.com'
    fill_in 'session_password', with: '123456'
    click_on 'commit'
    expect(page).to_not have_content 'Sign up'

    visit new_session_path
    save_and_open_page
    expect(page).to_not have_content 'Sign up'
  end
end