class AddActivoToFolios < ActiveRecord::Migration
  def change
    add_column :folios, :activo, :integer
  end
end
