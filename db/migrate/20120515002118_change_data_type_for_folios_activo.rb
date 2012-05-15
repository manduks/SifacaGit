class ChangeDataTypeForFoliosActivo < ActiveRecord::Migration
  def up
    change_table :folios do |t|
      t.change :activo, :string
    end
  end

  def down
  end
end
