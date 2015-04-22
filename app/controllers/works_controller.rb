class WorksController < ApplicationController
	def index
		# @works = Work.all

		# if i get to index action and days wildcard is present
		if (params[:days])
			# retrieve work via recent days method and include params days desc
			@works = Work.recentdays(params[:days]).order('datetimeperformed desc')
		else
			# else, show all works in desc
			@works = Work.all.order('datetimeperformed desc')
		end
	end

	def show
		@work = Work.find(params[:id])
	end	

end
