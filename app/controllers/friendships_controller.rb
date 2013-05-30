class FriendshipsController < ApplicationController
  def index
  	@users = User.all
    @following= current_user.following
    @followers= current_user.followers
    @friends = params[:page] ? current_user.facebook.get_page(params[:page]) : current_user.facebook.get_connections("me", "friends")

  end

  def create
  	@friendship = current_user.friendships.build(:friend_id => params[:friend_id])
  	if @friendship.save
  		flash[:notice] = "Amigo anadido"
  		redirect_to :back
  	else
  		flash[:error] = "No es posible Seguirlo !"
  		redirect_to :back
  	end
  end

  def destroy
  	@friendship = current_user.friendships.find(params[:id])
  	@friendship.destroy
  	flash[:notice] = "Eliminado exitosamente"
  	redirect_to :back
  end



end
