class UserMailer < ApplicationMailer
	default from: 'notifications@example.com'

	def welcome_email(user)
		@user = user
		@url  = 'http://path_to_server/login'
		mail(to: @user.customer_email, subject: 'Willkommen bei Terracamp')
	end

	def receive(email)
		page = Page.find_by(adress: email.to.first)
		page.emails.create(
			subject: email.subject,
			body: email.body
		)

		if email.has_attachments?
			email.attachments.each do |attachment|
				page.attachments.create({
					file: attachment,
					description: email.subject
				})
			end
		end
	end
end
