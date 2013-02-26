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
  def postear
    current_user.consignar_pezzos(777777)
    @user = User.find(session['user_id'])

    #ADDED: POST TO FACEBOOK
  #   api_key = '193467880799348'
  #   api_secret = '799b7d4d2b5bb906293cb6a30c405d45'
 
  #   client = OAuth2::Client.new(api_key, api_secret, :site => 'https://graph.facebook.com')
  #    token = OAuth2::AccessToken.new(client, session['fb_access_token'])
  # #   #token.post('/me/feed', :message => "testing this ....")
  #    me = FbGraph::User.me(session['fb_access_token'])

  # #   #me.friends
  # #   #if false
  #  me.feed!(
  #      :message => 'Apuesta ahora por tu equipo favorito!',
  #      :picture => 'https://fbcdn-sphotos-e-a.akamaihd.net/hphotos-ak-snc7/578495_319362508165730_718918976_n.jpg',
  #      :link => 'http://golazzos.herokuapp.com/',
  #      :name => 'Golazzos',
  #      :description => 'Golazzos la nueva Plataforma de apuestas sociales en Futbol.'
  #     )
    # @user.aumentar_posts
    #end
     #Al terminar el usuario es redirigido al inicio.
    @user.aumentar_posts
    @user.consignar_pezzos(10000)
    redirect_to 'invitations/new', :notice => "Gracias por publicar en tu muro, recibiste 10.000 Pezzos."  
  end

  def create
    @invitation = Invitation.new(params[:invitation])
    @invitation.sender = current_user

    if @invitation.save
      @user = User.find(session['user_id'])
      @user.aumentar_invitaciones
      

            @linkinvitation= "http://www.facebook.com/dialog/send?app_id=193467880799348&
name=Visita%20Golazzos%20y%20gana%20premios&
link=http://www.golazzos.com/home/"+@invitation.token+"/&to="+@invitation.recipient_uid+"&
redirect_uri=http://www.golazzos.com/"
   

      if @user.invitation_number == 10
        @user.consignar_pezzos(20000)
        # :notice => "Invitaste 10 personas, recibes 30000 Pezzos"
        flash[:notice] = "Invitaste 10 personas, recibes 20.000 Pezzos"
      end
      if @user.invitation_number == 20
        @user.consignar_pezzos(50000)
        flash[:notice] = "Invitaste 20 personas, recibes 50.000 Pezzos"
      end
      if @user.invitation_number == 30
        @user.consignar_pezzos(125000)
        flash[:notice] = "Invitaste 30 personas, recibes 125.000 Pezzos"
      end
      if @user.invitation_number == 40
        @user.consignar_pezzos(300000)
        flash[:notice] = "Invitaste 40 personas, recibes 300.000 Pezzos"
      end      
      if @user.invitation_number == 50
        @user.consignar_pezzos(750000)
        flash[:notice] = "Invitaste 50 personas, recibes 750.000 Pezzos"
      end
        render :msg, :notice => "Tu solicitud ha sido creada exitosamente."  
        #redirect_to root_url, :notice => "Successfully created invitation."  
           

    else
      render :action => 'new'
    end
  end
end
