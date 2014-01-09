class Client < ActiveRecord::Base
  belongs_to :user
  has_many :invoices
  has_many :students

  mount_uploader :logo_emp, LogoEmpUploader

  accepts_nested_attributes_for :students

  attr_accessible :students_attributes, :name, :rfc, :street, :num_ext, :num_int, :suburb, :township, :state,
                  :cp, :logo_emp, :email

  validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, :message => "No es un email valido" }

  validates_presence_of :name, :rfc, :street, :num_ext, :suburb, :township, :state, :cp, :message => "No puede estar Vacio"

  #validates_uniqueness_of :rfc, :scope => :user_id, :message => "Este RFC ya se dio de alta"
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

