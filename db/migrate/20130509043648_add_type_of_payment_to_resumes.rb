class AddTypeOfPaymentToResumes < ActiveRecord::Migration
  def up
    add_column :resumes, :type_of_payment, :string
  end

  def down
    remove_column :resumes, :type_of_payment
  end
end
