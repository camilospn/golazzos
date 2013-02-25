class BetsController < ApplicationController
	def create
		@partido= Partido.find(params[:partido_id])
		@user = User.find(params[:bet][:user_id])

		if @user.pezzos >= params[:bet][:monto].to_i
			@bet= @partido.bets.create(params[:bet])
			@user.descontar_pezzos(params[:bet][:monto].to_i)
			aumentar_apuestas
		else
			flash[:notice] = "No tienes suficientes Pezzos para realizar la apuesta"
		end
		
		
		#ADDED: POST TO FACEBOOK
		# api_key = '193467880799348'
 	# 	api_secret = '799b7d4d2b5bb906293cb6a30c405d45'
 
 	# 	client = OAuth2::Client.new(api_key, api_secret, :site => 'https://graph.facebook.com')
 	# 	token = OAuth2::AccessToken.new(client, session['fb_access_token'])
 	# 	#token.post('/me/feed', :message => "testing this ....")
 	# 	me = FbGraph::User.me(session['fb_access_token'])

 	# 	#me.friends
 	# 	#if false
		# me.feed!(
  #  		:message => 'Apuesta ahora!',
  # 		:picture => 'https://fbcdn-sphotos-e-a.akamaihd.net/hphotos-ak-snc7/578495_319362508165730_718918976_n.jpg',
  # 		:link => 'https://www.facebook.com/Golazzos',
  # 		:name => 'Golazzos',
  # 		:description => 'Golazzos la nueva Plataforma de apuestas sociales en Futbol.'
		#  )
		# @user.aumentar_posts
		#end
		 #Al terminar el usuario es redirigido al inicio.
		redirect_to partido_path(@partido)

	end
end
