class AddColumnToStudents < ActiveRecord::Migration
  def up
    add_column :students, :client_id, :integer
  end

  def down
    remove_column :students, :client_id
  end
end
