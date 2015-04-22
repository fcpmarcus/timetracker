class CompaniesController < ApplicationController
	def index
		@companies = Company.all
	end

	def show
		@company = Company.find(params[:id])
		@companies_id = params[:id]
	end
end
