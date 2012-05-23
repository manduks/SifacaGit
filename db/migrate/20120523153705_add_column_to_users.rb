class AddColumnToUsers < ActiveRecord::Migration
  def up
    add_column :users, :name, :string
    add_column :users, :rfc, :string
    add_column :users, :street, :string
    add_column :users, :num_ext, :string
    add_column :users, :num_int, :string
    add_column :users, :suburb, :string
    add_column :users, :township, :string
    add_column :users, :state, :string
    add_column :users, :cp, :integer
    add_column :users, :logo_emp, :string
    add_column :users, :username, :string
    add_column :users, :tax_regime, :integer, :default => 0
    add_column :users, :active, :integer, :default => 0
    add_column :users, :curp, :string
  end

  def down
    remove_column :users, :name
    remove_column :users, :rfc
    remove_column :users, :street
    remove_column :users, :num_ext
    remove_column :users, :num_int
    remove_column :users, :suburb
    remove_column :users, :township
    remove_column :users, :state
    remove_column :users, :cp
    remove_column :users, :logo_emp
    remove_column :users, :username
    remove_column :users, :tax_regime
    remove_column :users, :active
    remove_column :users, :curp
  end
end
