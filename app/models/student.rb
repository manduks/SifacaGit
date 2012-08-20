class Student < ActiveRecord::Base
  belongs_to :client

  validates_presence_of :name, :message => " Ingresa un Nombre"
  validates_presence_of :grade, :message => " Ingresa un grado escolar"
  #validates_presence_of :curp, :message => " Ingresa el curp"


end
