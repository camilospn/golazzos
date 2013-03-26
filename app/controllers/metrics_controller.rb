class MetricsController < ApplicationController
	before_filter :require_login_admin
	def index
	
	end
	def emails
		@users = User.all
	end
end
