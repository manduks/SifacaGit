class FolioDetail < ActiveRecord::Base
  belongs_to :invoice
  belongs_to :folio

  def self.find_by_folio_id_and_status(folio_id, status)
    where('folio_id = ? AND status = ?', folio_id, status)
  end
end
