class Folio < ActiveRecord::Base
  belongs_to :user
  has_many :folio_details

  mount_uploader :qr, LogoEmpUploader

  #validates :qr, :initiation, :finish, :presence => true
  #validates :initiation, :presence => true,
  #:numericality => {:only_integer => true,
  #                  :greater_than => Folio.maximum("finish", :conditions => ['user_id = ?', 9])}
  #validates :finish, :presence => true

  def self.find_activo_by_user_id(user_id)
    where('user_id = ? AND activo = ?', user_id, 1)
  end


  # user_id current_user
  # folio_id folio to not consider
  def self.find_max_by_user_id(user_id, folio_id)
    if folio_id.nil?
      Folio.maximum("finish", :conditions => ['user_id = ?', user_id])
    else
      Folio.maximum("finish", :conditions => ['user_id = ? AND id <> ?', user_id, folio_id])
    end
  end
end
