class SendNewsletter
	def run
		Customer.find_each do |customer|
			if customer.customer_newsletter == "Ja"
				UserMailer.newsletter(customer).deliver_now
			end
		end
	end
end