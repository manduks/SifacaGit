class ChangeDataTypeForUsersTaxRegime < ActiveRecord::Migration
  def up
    change_table :users do |t|
      t.change :tax_regime, :integer, :default => 0
    end
  end

  def down
    change_table :users do |t|
      t.change :tax_regime, :integer
    end
  end
end
