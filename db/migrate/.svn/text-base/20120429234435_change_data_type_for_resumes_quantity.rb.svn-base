class ChangeDataTypeForResumesQuantity < ActiveRecord::Migration
  def up
    change_table :resumes do |t|
      t.change :quantity, :decimal, {:scale =>2, :default =>0, :precision =>8}
    end
  end

  def down
  end
end
