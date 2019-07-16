require 'rails_helper'

RSpec.describe Task, type: :model do
      # 各テストの前にTaskを作成
      before do
        @task = Task.create(
          content: "SampleTask01",
          status: "未着手",
          priority: "高",
          deadline: "2019-08-01"
        )
        @other_task = Task.create(
          content: "SampleTask02",
          status: "完了",
          priority: "高",
          deadline: "2019-08-15"
        )
      end

  it "contentが空ならバリデーションが通らない" do
    task = Task.new(content: '', status: '失敗テスト', priority: '失敗テスト')
    #expect(task).not_to be_valid は、「task が妥当（valid）ではないことを期待する」という意味
    expect(task).not_to be_valid
  end

  it "contentが空ならバリデーションが通らない" do
    # ここに内容を記載する
    task = Task.new(content: '失敗テスト2', status: '', priority: '失敗テスト2')
    expect(task).not_to be_valid
  end

  it "titleとcontentに内容が記載されていればバリデーションが通る" do
    # ここに内容を記載する
    task = Task.new(content: '成功テスト', status: '', priority: '成功テスト')
  end

  it "内容：Task01で検索したらTask01が返ってくる" do
    expect(Task.all.get_by_content("Task01")).to include(@task)
  end

  it "ステータス：完了で検索したらTask02が返ってくる" do
    expect(Task.all.get_by_status("完了")).to include(@other_task)
  end  
end