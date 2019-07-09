require 'rails_helper'

RSpec.describe Task, type: :model do

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
end