class RenameColumnsToFolios < ActiveRecord::Migration
  def up
    rename_column :folios, :status, :activo
    rename_column :folios, :client_id, :user_id
  end

  def down
    rename_column :folios, :activo, :status
    rename_column :folios, :user_id, :client_id
  end
end
