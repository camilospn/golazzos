class SessionsController < ApplicationController
  def create
    @user = User.from_omniauth(env["omniauth.auth"])
    @user.aumentar_visitas
    session[:user_id] = @user.id
    #ADDED
    #Aqui se guarda el token de acceso que se necesita para todas las operaciones.
    session['fb_access_token'] = @user.oauth_token
    ##############
    if@user.visits_number==1
      @user.consignar_pezzos(50000)
      
      #revisa la invitacion
      #@invitacion= Invitation.find_by_token(session['guacamaya'])
       @invitacion= Invitation.find_by_recipient_uid(@user.uid)
      if @invitacion==nil
        flash[:notice] = "Recibes 50.000 Pezzos por tu primera visita"
      else
        if @invitacion.recipient_uid == @user.uid
          
          
          @user.update_attributes(invitation_id: @invitacion.id)
          @invitacion.update_attribute(:used, "true")
          @invitacion.actualizar_demora
          if @invitacion.demora <1
            flash[:notice] = "Recibes 50.000 Pezzos por tu primera visita. Recibiste 50.000 Pezzos extra gracias a que tu amigo te invito"  
            @user.consignar_pezzos(50000)
            #Le doy Pezzos al que me refirio.
            id_anfitrion=@invitacion.sender_id
            @usuario_anfitrion= User.find_by_id(id_anfitrion).consignar_pezzos(50000)
            #Asigno la invitacion al usuario si fue invitado
          else 
            flash[:notice] = "Recibes 20.000 Pezzos por tu primera visita. Recibiste 50.000 Pezzos extra gracias a que tu amigo te invito"  
            @user.consignar_pezzos(20000)
            #Le doy Pezzos al que me refirio.
            id_anfitrion=@invitacion.sender_id
            @usuario_anfitrion= User.find_by_id(id_anfitrion).consignar_pezzos(20000)
            #Asigno la invitacion al usuario si fue invitado
           
          end 

#          @demoraT=(Time.now - @invitacion.created_at.to_time)/1.day
 #         @invitacion.update_attributes(:demora, @demoraT)
        else
          flash[:notice] = "Solo recibes 50.000 Pezzos por tu primera visita, la invitacion no era para ti."  
        end

      end      
      #BD
      
      #flash[:notice] = "Recibes 20.000 Pezzos por tu primera visita"  
      
    end
    redirect_to "/partidos"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

end

