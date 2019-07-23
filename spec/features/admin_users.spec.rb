# 「FactoryBotを使用します」という記述
FactoryBot.define do

  factory :task ,class:Task do
    # content { 'test_task_01' }
    # status { '未着手' }
    # priority { 'low' }
    # deadline { "2019-07-07" }
    user
  end

  # factory :second_task,class: Task do
  #   content { 'test_task_02' }
  #   status { '完了' }
  #   priority { 'high' }
  #   deadline { "2019-07-10" }
  #   user
  # end

  factory :user ,class:User do
    # sequence(:name){|n| "test_user_#{n}"}
    # sequence(:email){|n| "hoge_#{n}@fuga.com"}
    name { 'user_01' }
    email { 'user01@hoge.com' }
    password { '123456' }
    password_confirmation { '123456' }
  end
end

# このrequireで、Capybaraなどの、Feature Specに必要な機能を使用可能な状態にしています
require 'rails_helper'

# このRSpec.featureの右側に、「タスク管理機能」のように、テスト項目の名称を書きます（do ~ endでグループ化されています）
RSpec.feature "タスク管理機能", type: :feature do
  
  background do
    @user = FactoryBot.create(:user)
    @task01 = FactoryBot.create(:task, user_id: @user.id, content: "test_task_01",status:"未着手",priority:"low",deadline:"2019-07-07")
    @task02 = FactoryBot.create(:task, user_id: @user.id, content: "test_task_02",status:"完了",priority:"high",deadline:"2019-07-10")

    def log_in
      visit sessions_new_path
      fill_in 'session_email', with: 'user01@hoge.com'
      fill_in 'session_password', with: '123456'
      click_on 'commit'
    end  
  end
  # 一覧、作成、詳細、更新、削除のテスト
  scenario "管理画面に遷移して作成したユーザーが表示されていることのテスト" do
    log_in
    click_on '管理画面'
    expect(page).to have_content 'user_01'
  end

  scenario "管理画面でユーザー作成のテスト" do
    log_in
    click_on '管理画面'
    click_on '新しくユーザを作成する'

    fill_in 'user_name', with: 'user_02'
    fill_in 'user_email', with: 'testuser02@abc.com'
    fill_in 'user_password', with: '123456'
    fill_in 'user_password_confirmation', with: '123456'
    click_on 'commit'
    expect(page).to have_content 'user_02'
    expect(page).to have_content 'testuser02@abc.com'
  end

  scenario "管理画面でユーザー詳細を確認するテスト" do
    log_in
    click_on '管理画面'
    first(:link, '詳細').click
    expect(page).to have_content 'user_01のページ'
    expect(page).to have_content 'user01@hoge.com'
    expect(page).to have_content 'test_task_01'
    expect(page).to have_content 'test_task_02'
    expect(page).to have_content 'ユーザが作成したタスクの数: 2'
  end

  scenario "管理画面でユーザーを更新のテスト" do
    log_in
    click_on '管理画面'
    first(:link, '編集').click
    expect(page).to have_content 'ユーザーを編集する'
    fill_in 'user_name', with: 'user_01v2'
    fill_in 'user_email', with: 'user01v2@hoge.com'
    fill_in 'user_password', with: '123456'
    fill_in 'user_password_confirmation', with: '123456'
    click_on 'commit'
    expect(page).to have_content 'user_01v2'
    expect(page).to have_content 'user01v2@hoge.com'
  end

  scenario "管理画面でユーザーを削除するテスト" do
    log_in
    click_on '管理画面'
    first(:link, '削除').click
    expect(page).to_not have_content 'user_01'
    expect(page).to_not have_content 'user01@hoge.com'
    save_and_open_page
  end
end