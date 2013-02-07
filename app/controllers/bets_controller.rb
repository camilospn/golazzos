class BetsController < ApplicationController
	def create
		@partido= Partido.find(params[:partido_id])
		@bet= @partido.bets.create(params[:bet])
		redirect_to partido_path(@partido)
	end
end
