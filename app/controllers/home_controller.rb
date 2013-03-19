class HomeController < ApplicationController
  def index
    @partido= Partido.where("diapartido > ?", Time.now).first
  end

  def reglamento
    
  end
  def referido
  		
    #Revisa si esta invitado o no esta invitado para mostrar un mensaje.  
  	
    @invitacion= Invitation.find_by_token(params[:invitation_token])
    session[:guacamaya]=params[:invitation_token]

    if @invitacion==nil
      flash[:notice] = "Invitacion no valida"  
    else
      flash[:notice] = "Has sido invitado a Golazzos, registrate y redime 50.000 Pezzos gratis!"  
    end

  end
end
