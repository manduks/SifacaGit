class ChangeColumnToResume < ActiveRecord::Migration
  def up
    change_column :resumes, :payment_condition, :string
  end

  def down
    change_column :resumes, :payment_condition, :integer
  end
end
