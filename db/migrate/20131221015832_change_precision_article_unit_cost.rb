class ChangePrecisionArticleUnitCost < ActiveRecord::Migration
  def up
    change_column :articles, :unit_cost, :decimal, {:scale =>2, :default =>0, :precision =>11}
  end

  def down
  end
end
