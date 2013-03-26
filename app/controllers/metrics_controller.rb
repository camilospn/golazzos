class MetricsController < ApplicationController
	before_filter :require_admin_admin
	def index
	
	end
	def emails
		@users = User.all
	end
end
