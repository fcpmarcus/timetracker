class Usermailer < ApplicationMailer
	default from: "mctestemail.01@gmail.com"

	def workcreated_email(work)
		@work = work
		mail(to: work.project.user.email, subject: "Work Item Posted")
	end
end
