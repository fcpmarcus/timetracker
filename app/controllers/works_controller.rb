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

	def new
		@work = Work.new
	end

	def create
		@work = Work.new(params[:work].permit(:project_id, :user_id, :datetimeperformed, :hours))
		if params[:doc]
			uploaded_io = params[:doc]
			File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
				file.write(uploaded_io.read)
				@work.doc = uploaded_io.original_filename	
			end
		end
		respond_to do |format|
			if @work.save
				Usermailer.workcreated_email(@work).deliver
				format.html { redirect_to @work, notice: 'Work Created' }
				format.js { }
			else
				format.html { render 'new' }
				format.js { }
			end
		end
	end

	def edit
		@work = Work.find(params[:id])
	end

	def update
		@work = Work.find(params[:id])
		if @work.update(params[:work].permit(:project_id, :user_id, :datetimeperformed, :hours))
			flash[:notice] = "Work Updated"
			redirect_to @work
		else
			render 'edit'
		end
	end

end
