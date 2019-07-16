class Task < ApplicationRecord
  validates :content, presence: true
  validates :status, presence: true
  validates :priority, presence: true

  # 内容による絞り込み
  # キーワードが入力されていれば、whereメソッドとLIKE検索（部分一致検索）を組み合わせて、必要な情報のみ取得する。
  scope :get_by_content, ->(content) {
    where("content like ?", "%#{content}%")
  }

  scope :get_by_status, ->(status) {
  where(status: status)
  }
end