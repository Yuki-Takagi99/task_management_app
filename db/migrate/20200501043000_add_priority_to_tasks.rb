class AddPriorityToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :priority, :integer, default: 0
    add_index :tasks, :priority
  end
end
