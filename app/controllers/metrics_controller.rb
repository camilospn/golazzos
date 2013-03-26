class MetricsController < ApplicationController
	before_filter :require_admin_login
	def index
	
	end
	def emails
		@users = User.all
	end
end
