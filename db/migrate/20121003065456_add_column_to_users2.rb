class AddColumnToUsers2 < ActiveRecord::Migration
  def up
    add_column :users, :regime, :string
  end

  def down
    remove_column :users, :regime
  end
end
