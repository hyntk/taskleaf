class ChangeDatatypePriorityOfTasks < ActiveRecord::Migration[5.2]
  def up
    change_column :tasks, :priority, 'integer USING CAST(status AS integer)', null: false
  end

  # 変更前の状態
  def down
    change_column :tasks, :priority, :string, null: false
  end  
end
