class ActivitiesController < ApplicationController
  def index
  	following_ids = current_user.following_ids
  	following_ids.push(1)
  	@activities =PublicActivity::Activity.order("created_at desc")
  	#@activities =PublicActivity::Activity.order("created_at desc").where(owner_id: following_ids, owner_type: "User")

  	@following= current_user.following
  	@followers= current_user.followers
  	@ranking_followers=current_user.following.sort_by { |e| -e[:pezzos]}
  end
end
