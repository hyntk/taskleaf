# 「FactoryBotを使用します」という記述
FactoryBot.define do

  factory :task do
    content { 'test_task_01' }
    status { '未着手' }
    priority { '低' }
    deadline { "2019-07-07" }
  end

  factory :second_task,class: Task do
    content { 'test_task_02' }
    status { '完了' }
    priority { '高' }
    deadline { "2019-07-10" }
  end
end

# このrequireで、Capybaraなどの、Feature Specに必要な機能を使用可能な状態にしています
require 'rails_helper'

# このRSpec.featureの右側に、「タスク管理機能」のように、テスト項目の名称を書きます（do ~ endでグループ化されています）
RSpec.feature "タスク管理機能", type: :feature do
  
  background do
    # あらかじめタスク一覧のテストで使用するためのタスクを二つ作成する
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
  end

  scenario "タスク一覧のテスト" do
    visit tasks_path

    expect(page).to have_content 'test_task_01'
    expect(page).to have_content 'test_task_02'
  end

  scenario "タスク作成のテスト" do
    visit new_task_path

    fill_in 'task_content', with: 'test_task_03'
    select '未着手',from: '状態'
    fill_in 'task_priority', with: '高'

    click_on '登録する'
    expect(page).to have_content 'test_task_03'
    expect(page).to have_content '未着手'
    expect(page).to have_content '高'
  end

  scenario "タスク詳細のテスト" do
    visit tasks_path
    click_on '詳細',match: :first
    expect(page).to have_content 'タスク詳細'
    expect(page).to have_content 'test_task_01'
    expect(page).to have_content '未着手'
    expect(page).to have_content '低'
    expect(page).to have_link '一覧'
  end

  scenario "タスクが作成日時の降順に並んでいるかのテスト" do

    visit tasks_path
    tds = page.all('td')
    expect(tds[0]).to have_content 'test_task_01'
    expect(tds[1]).to have_content '未着手'
    expect(tds[2]).to have_content '低'
    expect(tds[7]).to have_content 'test_task_02'
    expect(tds[8]).to have_content '完了'
    expect(tds[9]).to have_content '高'
  end

  scenario "期限付タスクが期限の降順に並んでいるかのテスト" do
    visit new_task_path

    fill_in 'task_content', with: 'test_task_04'
    select '未着手',from: '状態'
    fill_in 'task_priority', with: '高'
    select('2019', from: 'task_deadline_1i')
    select('12', from: 'task_deadline_2i')
    select('31', from: 'task_deadline_3i')

    click_on '登録する'

    click_on '終了期限でソートする'
    

    tds = page.all('td')
    expect(tds[0]).to have_content 'test_task_04'
    expect(tds[7]).to have_content 'test_task_02'
    expect(tds[14]).to have_content 'test_task_01'
  end

  scenario "検索条件に合致した内容のタスクが並んでいるかのテスト" do
    visit tasks_path
    save_and_open_page

    fill_in 'search', with: 'test_task_01'
    click_on 'commit'
    tds = page.all('td')
    expect(tds[0]).to have_content 'test_task_01'
    expect(page).to_not have_content 'test_task_02'
  end

  scenario "検索条件に合致した状態のタスクが並んでいるかのテスト" do
    visit tasks_path
    save_and_open_page

    select '未着手',from: 'status'
    click_on 'commit'
    tds = page.all('td')
    expect(tds[0]).to have_content 'test_task_01'
    expect(page).to_not have_content 'test_task_02'
  end  
end