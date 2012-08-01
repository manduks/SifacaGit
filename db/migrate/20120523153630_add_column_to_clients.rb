class AddColumnToClients < ActiveRecord::Migration
  def up
    add_column :clients, :user_id, :integer
    add_column :clients, :email, :string
    remove_column :clients, :qr
  end

  def down
    remove_column :clients, :user_id
    remove_column :clients, :email
    add_column :clients, :qr, :string
  end
end
