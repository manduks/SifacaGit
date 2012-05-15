class ChangeDataTypeForFoliosActivo < ActiveRecord::Migration
  def up
    change_column :folios, :activo, :integer
  end

  def down
    change_column :folios, :status, :string
  end
end
