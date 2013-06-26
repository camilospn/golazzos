class Invitacion2Controller < ApplicationController
  def index
  	@friends = current_user.facebook.get_connections("me", "friends?fields=id,name,picture.type(square)")
	@linkinvitation= "http://www.golazzos.com/home/#{current_user.uid}"

  end

end
