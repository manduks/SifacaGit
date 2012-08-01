class Invoice < ActiveRecord::Base
  belongs_to :client
  has_many :articles
  has_one :resume
  has_one :folio_detail

  accepts_nested_attributes_for :articles
  attr_accessible :articles_attributes, :date, :folio_detail_id, :client_id, :student_id, :status




  def self.find_invoice_by_client_id(client_id)
    where('client_id = ?', client_id)
  end
end
