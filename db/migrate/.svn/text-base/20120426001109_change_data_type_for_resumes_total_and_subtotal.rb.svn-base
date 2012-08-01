class ChangeDataTypeForResumesTotalAndSubtotal < ActiveRecord::Migration
  def up
    change_table :resumes do |t|
      t.change :subtotal, :decimal, {:scale =>2, :default =>0, :precision =>8}
      t.change :total, :decimal, {:scale =>2, :default =>0, :precision =>8}
    end

    change_table :articles do |f|
      f.change :unit_cost, :decimal, {:scale =>2, :default =>0, :precision =>8}
    end
  end

  def down
  end
end
