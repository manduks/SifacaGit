class AddQrToFolios < ActiveRecord::Migration
  def change
    add_column :folios, :qr, :string

  end
end
