class HomeController < ApplicationController
  def index
    @partido= Partido.where("diapartido > ?", Time.now).order("diapartido ASC").first
  end
  def index2
  end
  def reglamento
    
  end
  def contacto
    
  end
  def referido
  		
    #Revisa si esta invitado o no esta invitado para mostrar un mensaje.  
  	
    @invitacion= User.find_by_uid(params[:invitation_token])
    session[:guacamaya]=params[:invitation_token]

    if @invitacion==nil
      #flash[:notice] = "Invitación no válida"  
    else
      flash[:notice] = "Has sido invitado a Golazzos, registrate y redime 50.000 Pezzos gratis!"  
    end

  end
end
