class User < ActiveRecord::Base
  has_many :clients
  has_many :folios
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  #validates :current_password, :presence => false, :on => :update
  validates :email, :uniqueness => true

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :rfc, :street, :num_ext, :num_int,
                  :suburb, :township, :state, :cp, :logo_emp, :username, :tax_regime, :active, :curp
  #, :regime

  mount_uploader :logo_emp, LogoEmpUploader

  # bypasses Devise's requirement to re-enter current password to edit
  def update_without_password(params={})
    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end
    update_attributes(params)
  end
end

