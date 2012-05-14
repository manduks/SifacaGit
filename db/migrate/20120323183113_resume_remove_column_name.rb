class ResumeRemoveColumnName < ActiveRecord::Migration
  def up
    remove_column :resumes, :payment_condition
  end

  def down
  end
end
