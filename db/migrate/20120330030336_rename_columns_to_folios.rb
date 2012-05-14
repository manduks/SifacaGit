class RenameColumnsToFolios < ActiveRecord::Migration
  def up
    rename_column :folios, :status, :activo
    rename_column :folios, :client_id, :user_id
    change_column :folios, :activo, :integer
  end

  def down
    rename_column :folios, :activo, :status
    rename_column :folios, :user_id, :client_id
    change_column :folios, :status, :string
  end
end
