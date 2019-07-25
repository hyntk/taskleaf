class Lavel < ApplicationRecord
  has_many :lavellings, dependent: :destroy
  has_many :tasks, through: :lavellings
end
