class AddIvaFromResumes < ActiveRecord::Migration
  def change
    add_column :resumes, :iva, :integer
    add_column :resumes, :places, :string
    add_column :resumes, :quantity, :integer
    add_column :resumes, :concept, :string
    add_column :resumes, :ret_isr, :decimal, {:scale =>2, :default =>0, :precision =>8}
    add_column :resumes, :ret_iva, :decimal, {:scale =>2, :default =>0, :precision =>8}
  end
end
