class ChangePrecisionResumeColumns < ActiveRecord::Migration
  def up
    change_column :resumes, :ret_isr, :decimal, {:scale =>2, :default =>0, :precision =>11}
    change_column :resumes, :ret_iva, :decimal, {:scale =>2, :default =>0, :precision =>11}
    change_column :resumes, :subtotal, :decimal, {:scale =>2, :default =>0, :precision =>11}
    change_column :resumes, :total, :decimal, {:scale =>2, :default =>0, :precision =>11}
    change_column :resumes, :iva, :decimal, {:scale =>2, :default =>0, :precision =>11}
  end

  def down
  end
end
