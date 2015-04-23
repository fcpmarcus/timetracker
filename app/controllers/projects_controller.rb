class ProjectsController < ApplicationController
	def index
		@projects =  Project.all
	end

	def show
		# @project = Project.find(params[:id])
		if (params[:slug])
			@project = Project.find_by slug: params[:slug]
		else
			@project = Project.find(params[:id])
		end
	end

	def new
		@project = Project.new
	end

	def create
		@project = Project.new(params[:project].permit(:name, :slug, :default_rate, :company_id))
		if @project.save
			flash[:notice] = "Project Created"
			redirect_to @project
		else
			render 'new'
		end
	end
end
