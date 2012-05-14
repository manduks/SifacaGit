class Article < ActiveRecord::Base
  belongs_to :invoice

  #validates_presence_of :quantity, :message => " Ingresa una cantidad"
  #validates_presence_of :description, :message => " Ingresa una descripcion"
  #validates_presence_of :unit_cost, :message => " Ingresa el costo unitaario"
  #validates_numericality_of :unit_cost
  #validate :unit_cost_must_be_at_least_a_cent

  #Metodo para obtener el subtotal de la factura mediante el costo unitario y la cantidad
  def self.subtotal_multiplication(unit_cost, quantity)
    unit_cost * quantity
  end

  #Metodo para obtener el total de La factura con IVA
  def self.total_multiplication(unit_cost, quantity, iva)
    (unit_cost * quantity) * ((iva.nil? || iva == 0) ? 0 : (iva.to_f / 100))
  end

  def self.convert_words_number(number)
    number.to_words
  end

  protected
  def unit_cost_must_be_at_least_a_cent
      errors.add(:unit_cost, 'Debe ser mayor a 0.01') if unit_cost.nil? ||
          unit_cost < 0.01
  end

end
