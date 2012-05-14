class CreateResumes < ActiveRecord::Migration
  def change
    create_table :resumes do |t|
      t.integer :iva
      t.float :subtotal
      t.float :total
      t.integer :invoice_id
      t.string :letter_number
      t.string :payment_condition
      t.string :receipt

      t.timestamps
    end
  end
end
