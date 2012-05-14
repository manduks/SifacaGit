class AddColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :name, :string

    add_column :users, :rfc, :string

    add_column :users, :street, :string

    add_column :users, :num_ext, :string

    add_column :users, :num_int, :string

    add_column :users, :colony, :string

    add_column :users, :delegation, :string

    add_column :users, :state, :string

    add_column :users, :cp, :integer

    add_column :users, :logo_emp, :string

    add_column :users, :qr, :string

    add_column :users, :username, :string

  end
end
