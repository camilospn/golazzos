class Partido < ActiveRecord::Base
  include PublicActivity::Common
  
  attr_accessible :diapartido, :local, :logolocal, :logovisitante, :visitante, 
                  :terminado, :resultadoLocal, :resultadoVisitante, :cerrado, :repartido, :torneo

  validates :diapartido, presence: true 
  validates :local, presence: true
  validates :visitante, presence: true
  validates :logolocal, presence: true
  validates :logovisitante, presence: true
  validates :torneo, presence: true

  has_many :bets, :dependent => :destroy
  has_many :users, :through => :bets

  def apuestas_en_el_resultado(local, visitante)
    self.bets.where("\"golesLocal\"= ? AND \"golesVisitante\"= ?",local, visitante)
  end
  def monto_apostado_en_el_resultado(local, visitante)
  	#total=0
  	#self.apuestas_en_el_resultado(local, visitante).each do |bet|
		  #total+=bet.monto if !bet.monto.nil?
	  #end
  	#return total.to_f
    return self.apuestas_en_el_resultado(local,visitante).sum(:monto).to_f
  end

  def porcentaje_en_el_resultado(local, visitante, monto_futuro=0)
    montoResultado=self.monto_apostado_en_el_resultado(local, visitante)

    if (montoResultado + monto_futuro)==0
        return -1
    else
  	   return (montoResultado +monto_futuro)/ (self.monto_total_apostado + monto_futuro)
    end
  end

  def xveces_el_resultado(local, visitante, monto_futuro=0)
    porcentajeResultado =self.porcentaje_en_el_resultado(local,visitante, monto_futuro)
    
    if porcentajeResultado== -1
        return ((1 - 0.4)/self.porcentaje_en_el_resultado(local,visitante, 10000)) 
    else
  	   return ((1 - 0.4)/porcentajeResultado).round(1)
    end
  end

  def monto_total_apostado
	#total=0
  #	self.bets.each do |bet|
  #		total+=bet.monto if !bet.monto.nil?
  #	end
	#return total.to_f
  return self.bets.sum(:monto)

  end

  def monto_que_puedo_apostar_en_el_marcador(local, visitante)
    apuesta=((self.monto_total_apostado * 0.3) - self.monto_apostado_en_el_resultado(local, visitante))/(1-0.3)
    return apuesta
  end

  def supporters_partido(followings, partido)
    amigosLocal=[]
    amigosVisitante=[]
    amigosEmpate=[] 
    arreglos=[]

    followings.each do |fan|
      betSupporter = Bet.where(:user_id=>fan.id).where(:partido_id=>partido.id).first  
      
      if betSupporter==nil
      else
        
        nombreFan=fan.name
        fotoFan="https://graph.facebook.com/#{fan.uid}/picture"
        marcadorFan="#{partido.local} : #{betSupporter.golesLocal} - #{partido.visitante} : #{betSupporter.golesVisitante}"
        
        if betSupporter.golesLocal>betSupporter.golesVisitante
          as={name: nombreFan, pic: fotoFan, marcador: marcadorFan}
          amigosLocal.push(as)
        else
          if betSupporter.golesLocal<betSupporter.golesVisitante
            as={name: nombreFan, pic: fotoFan, marcador: marcadorFan}
            amigosVisitante.push(as)
          else
            as={name: nombreFan, pic: fotoFan, marcador: marcadorFan}
            amigosEmpate.push(as)
          end 
        end 
      end
    
    end#End del for.

    as={local: amigosLocal, visitante: amigosVisitante, empate: amigosEmpate}
    #arreglos.push(amigosLocal)
    #arreglos.push(amigosVisitante)
    #arreglos.push(amigosEmpate)
    arreglos.push(as)
    return arreglos
  end

  def repartir_la_plata
    bets_ganadoras = self.apuestas_en_el_resultado(self.resultadoLocal, self.resultadoVisitante)
    bets_ganadoras.each do |bet|
      pezzos_ganados = bet.monto * xveces_el_resultado(self.resultadoLocal, self.resultadoVisitante)
      bet.update_attributes(pezzos_ganados: pezzos_ganados, repartido: true)
      User.find(bet.user_id).consignar_pezzos(pezzos_ganados) 
    end
  end

  def apuestas_del_usuario(user)
      return self.bets.where(user_id: user.id)
  end

  def ganancias_del_usuario(user)
    return self.apuestas_del_usuario(user).sum(:pezzos_ganados)
  end
end
