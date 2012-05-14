class ClientsColumnName < ActiveRecord::Migration
  def up
    rename_column :clients, :id_user, :user_id
  end

  def down
  end
end
