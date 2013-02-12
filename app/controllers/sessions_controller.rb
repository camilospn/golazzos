class SessionsController < ApplicationController
  def create
    @user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = @user.id
    @user.consignar_pezzos(50000)
    redirect_to "/partidos"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end

