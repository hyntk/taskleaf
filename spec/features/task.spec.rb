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

    def make_label
      visit new_lavel_path
      fill_in 'lavel_name',with: 'test_label_01'
      click_on 'commit'
      fill_in 'lavel_name',with: 'test_label_02'
      click_on 'commit'
      fill_in 'lavel_name',with: 'test_label_03'
      click_on 'commit'
    end

    # あらかじめタスク一覧のテストで使用するためのタスクを二つ作成する
    # FactoryBot.create(:task)
    # FactoryBot.create(:second_task)
  end

  scenario "タスク一覧のテスト" do
    log_in
    click_on '一覧'
    expect(page).to have_content 'test_task_01'
    expect(page).to have_content 'test_task_02'
  end

  scenario "タスク作成のテスト" do
    make_label
    log_in
    visit new_task_path

    fill_in 'task_content', with: 'test_task_03'
    select '未着手',from: '状態'
    select '高',from: '優先順位'
    check 'test_label_01'
    check 'test_label_02'


    click_on '登録する'
    expect(page).to have_content 'test_task_03'
    expect(page).to have_content '未着手'
    expect(page).to have_content '高'
    all(:link, '詳細').last.click
    
    expect(page).to have_content 'test_label_01'
    expect(page).to have_content 'test_label_02'
  end

  scenario "タスク詳細のテスト" do
    log_in
    visit tasks_path
    # click_link '詳細',match: :first
    first(:link, '詳細').click
    expect(page).to have_content 'タスク詳細'
    expect(page).to have_content 'test_task_01'
    expect(page).to have_content '未着手'
    expect(page).to have_content '低'
    expect(page).to have_link '一覧'
  end

  scenario "タスクが作成日時の降順に並んでいるかのテスト" do
    log_in
    visit tasks_path
    
    tds = page.all('td')
    expect(tds[0]).to have_content 'test_task_01'
    expect(tds[1]).to have_content '未着手'
    expect(tds[2]).to have_content '低'
    expect(tds[8]).to have_content 'test_task_02'
    expect(tds[9]).to have_content '完了'
    expect(tds[10]).to have_content '高'
  end

  scenario "期限付タスクが期限の降順に並んでいるかのテスト" do
    log_in
    visit new_task_path

    fill_in 'task_content', with: 'test_task_04'
    select '未着手',from: '状態'
    select '高',from: '優先順位'
    select('2019', from: 'task_deadline_1i')
    select('12', from: 'task_deadline_2i')
    select('31', from: 'task_deadline_3i')

    click_on '登録する'

    click_on '終了期限でソートする'
    

    tds = page.all('td')
    expect(tds[0]).to have_content 'test_task_04'
    expect(tds[8]).to have_content 'test_task_02'
    expect(tds[16]).to have_content 'test_task_01'
  end

  scenario "検索条件に合致した内容のタスクが並んでいるかのテスト" do
    log_in
    visit tasks_path

    fill_in 'search', with: 'test_task_01'
    click_on 'commit'
    tds = page.all('td')
    expect(tds[0]).to have_content 'test_task_01'
    expect(page).to_not have_content 'test_task_02'
  end

  scenario "内容の検索条件に合致した状態のタスクが並んでいるかのテスト" do
    log_in
    visit tasks_path

    select '未着手',from: 'status'
    click_on 'commit'
    tds = page.all('td')
    expect(tds[0]).to have_content 'test_task_01'
    expect(page).to_not have_content 'test_task_02'
  end

  scenario "優先順位の降順にタスクが並んでいるかのテスト" do
    log_in
    visit new_task_path

    fill_in 'task_content', with: 'test_task_04'
    select '未着手',from: '状態'
    select '中',from: '優先順位'
    select('2019', from: 'task_deadline_1i')
    select('12', from: 'task_deadline_2i')
    select('31', from: 'task_deadline_3i')

    click_on '登録する'

    click_on '優先順位でソートする'  
    tds = page.all('td')
    expect(tds[0]).to have_content 'test_task_02'
    expect(tds[8]).to have_content 'test_task_04'
    expect(tds[16]).to have_content 'test_task_01'
  end
end