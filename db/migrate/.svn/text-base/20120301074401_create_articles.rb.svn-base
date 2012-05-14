class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer :quantity
      t.string :description
      t.float :unit_cost
      t.integer :iva
      t.integer :invoice_id

      t.timestamps
    end
  end
end
