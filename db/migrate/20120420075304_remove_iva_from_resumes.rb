class RemoveIvaFromResumes < ActiveRecord::Migration
  def up
    remove_column :resumes, :iva
      end

  def down
    add_column :resumes, :iva, :integer
  end
end
