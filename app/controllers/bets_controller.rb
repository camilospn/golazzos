class BetsController < ApplicationController
	def create
		@partido= Partido.find(params[:partido_id])
		@user = User.find(params[:bet][:user_id])

		if @user.pezzos >= params[:bet][:monto].to_i
			@bet= @partido.bets.create(params[:bet])
			@user.descontar_pezzos(params[:bet][:monto].to_i)
			@user.aumentar_apuestas
			@user.consignar_pezzos(5000)
			flash[:notice] = "Apuesta creada correctamente. Recibes 5000 Pezzos por tu actividad."
		else
			flash[:notice] = "No tienes suficientes Pezzos para realizar la apuesta"
		end
		
		
		redirect_to partido_path(@partido)

	end
end
