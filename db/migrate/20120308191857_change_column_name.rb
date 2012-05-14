class ChangeColumnName < ActiveRecord::Migration
  def up
    rename_column :users, :colony, :suburb
    rename_column :users, :delegation, :township
  end

  def down
  end
end
