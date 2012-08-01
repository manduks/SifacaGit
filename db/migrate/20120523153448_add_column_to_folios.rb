class AddColumnToFolios < ActiveRecord::Migration
  def up
    add_column :folios, :initiation, :integer
    add_column :folios, :qr, :string
    add_column :folios, :date_initiation, :date
    add_column :folios, :date_finish, :date
    add_column :folios, :approval, :integer
    add_column :folios, :activo, :integer
    remove_column :folios, :status
    rename_column :folios, :folio, :finish
    rename_column :folios, :client_id, :user_id
  end

  def down
    remove_column :folios, :initiation
    remove_column :folios, :qr
    remove_column :folios, :date_initiation
    remove_column :folios, :date_finish
    remove_column :folios, :approval
    remove_column :folios, :activo
    add_column :folios, :status, :string
    rename_column :folios, :finish, :folio
    rename_column :folios, :user_id, :client_id
  end
end
