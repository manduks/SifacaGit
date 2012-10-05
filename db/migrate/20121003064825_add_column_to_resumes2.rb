class AddColumnToResumes2 < ActiveRecord::Migration
  def up
    add_column :resumes, :payment_system, :integer
    add_column :resumes, :account_number, :integer
  end

  def down
    remove_column :resumes, :payment_system
    remove_column :resumes, :account_number
  end
end
