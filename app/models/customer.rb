class Customer < ApplicationRecord
	has_many :receipts

	def self.search(search)
		where('customer_name LIKE :search OR customer_surname LIKE :search OR customer_street LIKE :search OR customer_town LIKE :search', search: "%#{search}%")
	end

	def full_name
		"#{customer_surname}, #{customer_name}"
	end

end
