class MetricsController < ApplicationController
  def index
  end
  def estampas
  	  #Crea cada registro...
      @registro = Metrics.new()
      
      @registro.total_usuarios=User.count
	  @registro.total_apuestas=Bet.all.count
	  @registro.apuestas_usuario=User.average(:bets_number)
	  @registro.total_referidos=User.where('invitation_id  IS NOT NULL').count
	  @registro.referidos_usuario=User.average(:referidos)
	  @registro.login_usuario=User.average(:visits_number)
	  @registro.posts_usuario=User.average(:post_on_fb)
	  @registro.sinapostar_usuarios=User.where(:bets_number =>0).count
	  
      if @registro.save
        #algo sucede...
      end
  end
end
