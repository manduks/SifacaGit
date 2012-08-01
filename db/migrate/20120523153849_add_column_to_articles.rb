class AddColumnToArticles < ActiveRecord::Migration
  def up
    remove_column :articles, :unit_cost
    add_column :articles, :unit_cost, :decimal, {:scale =>2, :default =>0, :precision =>8}
  end

  def down
    remove_column :articles, :unit_cost
    add_column :articles, :unit_cost, :float
  end
end
