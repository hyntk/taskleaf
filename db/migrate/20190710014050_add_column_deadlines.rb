class AddColumnDeadlines < ActiveRecord::Migration[5.2]
  def up
    add_column :tasks, :deadline, :date
  end

  def down
    remove_column :tasks, :deadline, :date
  end
end