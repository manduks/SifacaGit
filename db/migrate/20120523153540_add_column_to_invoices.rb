class AddColumnToInvoices < ActiveRecord::Migration
  def up
    add_column :invoices, :status, :integer
    add_column :invoices, :student_id, :integer
    rename_column :invoices, :folio_id, :folio_detail_id
  end

  def down
    remove_column :invoices, :status
    remove_column :invoices, :student_id
    rename_column :invoices, :folio_detail_id, :folio_id
  end
end
