class InvitationsController < ApplicationController
  before_filter :require_login
  def new
    @invitation = Invitation.new
    @linkwallpost= "https://www.facebook.com/dialog/feed?
  app_id=193467880799348&
  link=https://www.golazzos.com/&
  name=Visita%20Golazzos%20y%20gana%20premios&
  caption=La%20nueva%20plataforma%20de%20apuestas%20sociales%20en%20futbol&
  description=.&
  redirect_uri=http://www.golazzos.com/"

  end

  def create
    @invitados = params[:invited_uids]
    @mensaje = "hola "
    #Para cada usuario creamos una invitacion, tendrian el mismo token
    @invitados.each do |invi|

      @mensaje = @mensaje + "\n " + invi.to_s
      #Crea cada invitacion...
      @invitation = Invitation.new()
      @invitation.recipient_uid = invi.to_s
      @invitation.sender = current_user
      @invitation.token = current_user.uid

      if @invitation.save
        @user = User.find(session['user_id'])
        @user.aumentar_invitaciones
      end

    end
    #terminaron las invitaciones

@linkinvitation= "http://www.facebook.com/dialog/send?app_id=116412671734664&link=http://developers.facebook.com/docs/reference/dialogs/&redirect_uri=http://www.jetsetter.com/&to=100000910418225,590528674"

        @linkinvitation= "http://www.facebook.com/dialog/send?app_id=193467880799348&
name=Visita%20Golazzos%20y%20gana%20premios&
link=http://www.golazzos.com/home/"+current_user.uid+"/&
redirect_uri=http://www.golazzos.com/&to=100003778647592100001682753858"
    
    @linkinvitation= "https://www.facebook.com/dialog/apprequests?
  app_id=193467880799348&
  message=Visita%20Golazzos%20y%20gana%20premios&to="+@invitados.to_s+"&redirect_uri=http://localhost:3000/invitations/new"
 
 

    #redirect_to root_url, :notice => @mensaje
    render :msg, :notice => "Tu solicitud ha sido creada exitosamente."  

  end
  #termino create

end
