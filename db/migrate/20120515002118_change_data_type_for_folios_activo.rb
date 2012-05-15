class ChangeDataTypeForFoliosActivo < ActiveRecord::Migration
  def up
    change_column :folios, :activo, :integer
  end

  def down
  end
end
