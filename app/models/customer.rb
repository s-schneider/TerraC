class Customer < ApplicationRecord
	include Filterable
	has_many :receipts

	scope :cgroup, -> (customer_group) {where customer_group: customer_group}

	def self.search(search)
		where('customer_name LIKE :search OR customer_surname LIKE :search OR customer_street LIKE :search OR customer_town LIKE :search', search: "%#{search}%")
	end

	def full_name
		"#{customer_surname}, #{customer_name}"
	end

end
