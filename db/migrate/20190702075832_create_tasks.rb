class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.text :content
      t.string :status
      t.string :priority

      t.timestamps
    end
  end
end
