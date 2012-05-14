class ChangeDataTypeForResumesIva < ActiveRecord::Migration
  def up
    change_table :resumes do |t|
      t.change :iva, :decimal, {:scale =>2, :default =>0, :precision =>8}
    end
  end

  def down
  end
end
