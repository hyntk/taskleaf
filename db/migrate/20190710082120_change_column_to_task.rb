class ChangeColumnToTask < ActiveRecord::Migration[5.2]
  def up
    change_column :tasks, :deadline, :date, null: false
  end

  # 変更前の状態
  def down
    change_column :tasks, :deadline, :date, null: true
  end
end
