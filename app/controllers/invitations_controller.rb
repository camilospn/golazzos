class InvitationsController < ApplicationController
  before_filter :require_login
  def new
    @invitation = Invitation.new
  end
  def msg
    
  end

  def create
    @invitation = Invitation.new(params[:invitation])
    @invitation.sender = current_user

    if @invitation.save
      @user = User.find(session['user_id'])
      @user.aumentar_invitaciones
      
      if @user.invitation_number == 10
        @user.consignar_pezzos(30000)
        redirect_to root_url, :notice => "Invitaste 10 personas, recibes 30000 Pezzos"
      else
            @linkinvitation= "http://www.facebook.com/dialog/send?app_id=193467880799348&
name=Visita%20Golazzos%20y%20gana%20premios&
link=http://golazzos.herokuapp.com/home/"+@invitation.token+"/&to="+@invitation.recipient_uid+"&
redirect_uri=http://golazzos.herokuapp.com/"
        render :msg
        #redirect_to root_url, :notice => "Successfully created invitation."  
      end     

    else
      render :action => 'new'
    end
  end
end
