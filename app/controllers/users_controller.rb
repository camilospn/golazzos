class UsersController < ApplicationController
  def index
    @users= User.order("pezzos DESC")
  end

  def show
    @user= User.find(params[:id])
  end

  def update
  	
  	respond_to do |format|
      if current_user.update_attributes(params[:user])
        format.html { redirect_to :back }
        format.js
      else
        format.html { render action: "no se puedo cambiar el monto a apostar" }
        format.js 
      end
  	end
  end

end