class AddColumnsToFolio2 < ActiveRecord::Migration
  def change
    add_column :folios, :date_initiation, :date
    add_column :folios, :date_finish, :date
    add_column :folios, :approval, :integer
  end
end
