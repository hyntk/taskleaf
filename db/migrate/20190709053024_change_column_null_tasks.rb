class ChangeColumnNullTasks < ActiveRecord::Migration[5.2]
  def up
    change_column :tasks, :content, :text, null: false
    change_column :tasks, :status, :string, null: false
    change_column :tasks, :priority, :string, null: false
  end

  # 変更前の状態
  def down
    change_column :tasks, :content, :text, null: true
    change_column :tasks, :status, :string, null: true
    change_column :tasks, :priority, :string, null: true
  end
end
