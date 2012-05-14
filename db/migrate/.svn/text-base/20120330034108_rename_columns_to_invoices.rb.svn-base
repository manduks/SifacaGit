class RenameColumnsToInvoices < ActiveRecord::Migration
  def up
    rename_column :invoices, :folio_id, :folio_detail_id
  end

  def down
    rename_column :invoices, :folio_detail_id, :folio_id
  end
end
