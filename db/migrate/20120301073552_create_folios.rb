class CreateFolios < ActiveRecord::Migration
  def change
    create_table :folios do |t|
      t.integer :client_id
      t.integer :folio
      t.string :status

      t.timestamps
    end
  end
end
