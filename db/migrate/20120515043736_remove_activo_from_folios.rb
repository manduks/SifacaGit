class RemoveActivoFromFolios < ActiveRecord::Migration
  def up
    remove_column :folios, :activo
  end

  def down
  end
end
