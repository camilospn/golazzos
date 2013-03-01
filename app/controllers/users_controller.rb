class UsersController < ApplicationController
  def index
    @users= User.order("pezzos DESC")
  end

  def show
    @user= User.find(params[:id])

    if @user.partidos.any?
      if params[:partidoId]
        @partido= Partido.find(params[:partidoId])
      else
        @partido = @user.partidos.first
      end

      @bets= @partido.bets.where("user_id = ?", @user.id) 
    end   
    @pezzos_por_amigos= User.where('invitation_id = ?', @user.id).count * 50000
    @pezzos_por_actividad= @user.bets.count * 5000 

  end

  def update
  	current_user.update_attributes(params[:user])
    @partido = Partido.find(params[:partido_actual_id])
    respond_to do |format|
      format.html { redirect_to :back}
      format.js
    end
  end

end