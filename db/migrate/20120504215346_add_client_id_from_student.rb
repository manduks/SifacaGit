class AddClientIdFromStudent < ActiveRecord::Migration
  def change
    add_column :students, :client_id, :integer
  end
end
