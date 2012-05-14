class ChangeColumnName < ActiveRecord::Migration
  def up
    rename_column :Users, :colony, :suburb
    rename_column :Users, :delegation, :township
  end

  def down
  end
end
