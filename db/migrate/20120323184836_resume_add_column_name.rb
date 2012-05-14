class ResumeAddColumnName < ActiveRecord::Migration
  def up
    add_column :resumes, :payment_condition, :integer
  end

  def down
  end
end
