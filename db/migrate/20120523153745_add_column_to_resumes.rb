class AddColumnToResumes < ActiveRecord::Migration
  def up
    remove_column :resumes, :subtotal
    remove_column :resumes, :total
    remove_column :resumes, :iva
    add_column :resumes, :places, :string
    add_column :resumes, :tax_regime, :integer
    add_column :resumes, :concept, :string
    add_column :resumes, :quantity, :decimal, {:scale =>2, :default =>0, :precision =>8}
    add_column :resumes, :ret_isr, :decimal, {:scale =>2, :default =>0, :precision =>8}
    add_column :resumes, :ret_iva, :decimal, {:scale =>2, :default =>0, :precision =>8}
    add_column :resumes, :subtotal, :decimal, {:scale =>2, :default =>0, :precision =>8}
    add_column :resumes, :total, :decimal, {:scale =>2, :default =>0, :precision =>8}
    add_column :resumes, :iva, :decimal, {:scale =>2, :default =>0, :precision =>8}
  end

  def down
    remove_column :resumes, :places
    remove_column :resumes, :tax_regime
    remove_column :resumes, :concept
    remove_column :resumes, :quantity
    remove_column :resumes, :ret_isr
    remove_column :resumes, :ret_iva
    remove_column :resumes, :subtotal
    remove_column :resumes, :total
    remove_column :resumes, :iva
    add_column :resumes, :subtotal, :float
    add_column :resumes, :total, :float
    add_column :resumes, :iva, :integer
  end
end
