class Resume < ActiveRecord::Base
  belongs_to :invoice
  #has_one :invoice

  attr_accessible :concept, :iva, :letter_number, :places, :quantity, :ret_isr, :ret_iva, :subtotal, :total,
                  :payment_condition, :receipt
                  #, :payment_system, :account_number


  def self.search(search)
    if search
      Client.where('name LIKE ?', "%#{search}%")
    else
      scoped
    end
  end

  def self.search_by_invoice_id(invoices, search)
    if search
      Resume.find(:all,
                  :joins => [:invoice],
                  :conditions => ['resumes.invoice_id IN (?) AND (resumes.payment_condition like ? OR invoices.date like ?)',
                                  get_ids(invoices), "%#{search}%", "%#{search}%"])
      #where('invoice_id IN (?) AND (payment_condition like ? OR date like ?)', get_ids(invoices), "%#{search}%", "%#{search}%")
    end
  end

  def self.get_ids(objects)
    ids = []
    objects.each do |object|
      ids << object.id
    end
    return ids
  end


end
