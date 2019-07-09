# 「FactoryBotを使用します」という記述
FactoryBot.define do

  # 作成するテストデータの名前を「task」とします
  # （実際に存在するクラス名と一致するテストデータの名前をつければ、そのクラスのテストデータを自動で作成します）
  factory :task do
    content { 'test_task_01' }
    status { '未着手' }
    priority { '低' }
  end
end

# このrequireで、Capybaraなどの、Feature Specに必要な機能を使用可能な状態にしています
require 'rails_helper'

# このRSpec.featureの右側に、「タスク管理機能」のように、テスト項目の名称を書きます（do ~ endでグループ化されています）
RSpec.feature "タスク管理機能", type: :feature do
  
  background do
    # あらかじめタスク一覧のテストで使用するためのタスクを二つ作成する
    FactoryBot.create(:task,content:'test_task_01')
    FactoryBot.create(:task,content:'test_task_02',priority:'高')
    # backgroundの中に記載された記述は、そのカテゴリ内（feature "タスク管理機能", type: :feature do から endまでの内部）
    # に存在する全ての処理内（scenario内）で実行される
    # （「タスク一覧のテスト」でも「タスクが作成日時の降順に並んでいるかのテスト」でも、background内のコードが実行される）
    # Task.create!(content: 'test_task_01', status: '未着手',priority: '低')
    # Task.create!(content: 'test_task_02', status: '未着手',priority: '高')
  end

  # scenario（itのalias）の中に、確認したい各項目のテストの処理を書きます。
  scenario "タスク一覧のテスト" do
    # あらかじめタスク一覧のテストで使用するためのタスクを二つ作成する
    # Task.create!(content: 'test_task_01', status: '未着手',priority: '低')
    # Task.create!(content: 'test_task_02', status: '未着手',priority: '高')

    # tasks_pathにvisitする（タスク一覧ページに遷移する）
    visit tasks_path
    save_and_open_page

    # visitした（到着した）expect(page)に（タスク一覧ページに）「testtesttest」「samplesample」という文字列が
    # have_contentされているか？（含まれているか？）ということをexpectする（確認・期待する）テストを書いている
    expect(page).to have_content 'test_task_01'
    expect(page).to have_content 'test_task_02'
  end

  scenario "タスク作成のテスト" do
    # new_task_pathにvisitする（タスク登録ページに遷移する）
    # 1.ここにnew_task_pathにvisitする処理を書く
    visit new_task_path
    # 「タスク名」というラベル名の入力欄と、「タスク詳細」というラベル名の入力欄に
    # タスクのタイトルと内容をそれぞれfill_in（入力）する
    # 2.ここに「タスク名」というラベル名の入力欄に内容をfill_in（入力）する処理を書く
    # 3.ここに「タスク詳細」というラベル名の入力欄に内容をfill_in（入力）する処理を書く
    fill_in 'task_content', with: 'test_task_03'
    fill_in 'task_status', with: '未着手'
    fill_in 'task_priority', with: '高'
    # 「登録する」というvalue（表記文字）のあるボタンをclick_onする（クリックする）
    # 4.「登録する」というvalue（表記文字）のあるボタンをclick_onする（クリックする）する処理を書く
    click_on '登録する'
    # clickで登録されたはずの情報が、タスク詳細ページに表示されているかを確認する
    # （タスクが登録されたらタスク詳細画面に遷移されるという前提）
    # 5.タスク詳細ページに、テストコードで作成したはずのデータ（記述）がhave_contentされているか（含まれているか）を確認（期待）するコードを書く
    expect(page).to have_content 'test_task_03'
    expect(page).to have_content '未着手'
    expect(page).to have_content '高'

  end

  scenario "タスク詳細のテスト" do
    visit tasks_path
    click_on '詳細',match: :first
    expect(page).to have_content 'タスク詳細'
    expect(page).to have_content 'test_task_02'
    expect(page).to have_content '未着手'
    expect(page).to have_content '高'
    expect(page).to have_link '一覧'
  end

  scenario "タスクが作成日時の降順に並んでいるかのテスト" do
    # ここにテスト内容を記載する
    # tasks_pathにvisitする（タスク一覧ページに遷移する）
    visit tasks_path

    tds = page.all('td')
    expect(tds[0]).to have_content 'test_task_02'
    expect(tds[1]).to have_content '未着手'
    expect(tds[2]).to have_content '高'
    expect(tds[6]).to have_content 'test_task_01'
    expect(tds[7]).to have_content '未着手'
    expect(tds[8]).to have_content '低'
  end
end