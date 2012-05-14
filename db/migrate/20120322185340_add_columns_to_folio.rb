class AddColumnsToFolio < ActiveRecord::Migration
  def change
    add_column :folios, :initiation, :integer

  end
end
