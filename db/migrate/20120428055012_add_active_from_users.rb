class AddActiveFromUsers < ActiveRecord::Migration
  def change
    add_column :users, :active, :integer, :default => 0
  end
end
