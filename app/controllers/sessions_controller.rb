class SessionsController < ApplicationController
  def create
    @user = User.from_omniauth(env["omniauth.auth"])
    @user.aumentar_visitas
    session[:user_id] = @user.id
    #Aqui se guarda el token de acceso que se necesita para todas las operaciones.
    session['fb_access_token'] = @user.oauth_token
    if@user.visits_number==1
      @user.consignar_pezzos(50000)
      #revisa referido
      @anfitrion= User.find_by_uid(session['guacamaya'])
      if @anfitrion==nil #No es referido
        flash[:notice] = "Recibes 50.000 Pezzos por tu primera visita"
      else
        if @user.uid == @user.uid
          if true
            flash[:notice] = "Recibes 50.000 Pezzos por tu primera visita. Recibiste 50.000 Pezzos extra gracias a que tu amigo te invito"  
            @user.consignar_pezzos(50000)
            @anfitrion.consignar_pezzos(50000)
            @anfitrion.aumentar_referidos
            @user.update_attributes(invitation_id: @anfitrion.id)
          end 
        else
          flash[:notice] = "Solo recibes 50.000 Pezzos por tu primera visita, la invitacion no era para ti."  
        end
      end      
    end
    if@user.visits_number==1
      redirect_to invitacion2_index_path
    else
      redirect_to activities_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

end

