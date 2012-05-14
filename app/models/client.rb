class Client < ActiveRecord::Base
  belongs_to :user
  has_many :invoices
  has_many :students

  mount_uploader :logo_emp, LogoEmpUploader

  accepts_nested_attributes_for :students

  attr_accessible :students_attributes, :name, :rfc, :street, :num_ext, :num_int, :suburb, :township, :state,
                  :cp, :logo_emp, :email

  #validates :name, :rfc, :street, :num_ext, :num_int, :suburb, :township, :state, :cp, :presence => true

  #validates_presence_of :name, :message => "No puede estar Vacio"

  #validates :logo_emp, :format => {
   #       :with => %r{\.(gif|jpg|png)$}i,
    #      :message => 'must be a URL for GIF, JPG or PNG image.'
     # }

  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      scoped
    end
  end

  def self.find_by_user_id(user_id)
    where('user_id = ?', "#{user_id}")
  end

end

