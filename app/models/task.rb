class Task < ApplicationRecord
  validates :content, presence: true
  validates :status, presence: true
  validates :priority, presence: true
end
