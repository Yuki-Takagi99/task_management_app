class AddEndDeadlineToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :end_deadline, :datetime, null: false, default: -> { 'NOW()'}
  end
end
