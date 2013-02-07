class Partido < ActiveRecord::Base
  attr_accessible :diapartido, :local, :logolocal, :logovisitante, :visitante

  validates :diapartido, presence: true 
  validates :local, presence: true
  validates :visitante, presence: true
  validates :logolocal, presence: true
  validates :logovisitante, presence: true

  has_many :bets

  def monto_apostado_en_el_resultado(local, visitante)
  	total=0
  	self.bets.where("golesLocal= ? AND golesVisitante= ?",local, visitante).each do |bet|
		total+=bet.monto if !bet.monto.nil?
	end
	return total.to_f
  end

  def porcentaje_en_el_resultado(local, visitante)
  	self.monto_apostado_en_el_resultado(local, visitante)/ self.monto_total_apostado
  end

  def xveces_el_resultado(local, visitante)
  	return ((1 - 0.39)/self.porcentaje_en_el_resultado(local,visitante)) 
  end

  def monto_total_apostado
	total=0
	self.bets.each do |bet|
		total+=bet.monto if !bet.monto.nil?
	end
	return total.to_f
  end

end
