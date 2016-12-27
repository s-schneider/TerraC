class Supplier < ApplicationRecord
	has_many :receipts
	
	def self.search(search)
		where('name LIKE :search', search: "%#{search}%")
	end
end
