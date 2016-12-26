class Receipt < ApplicationRecord
	include  Filterable 
	belongs_to :customer

	scope :type, -> (receipt_type) {where receipt_type: receipt_type}
	scope :person, -> (receipt_person) {where receipt_person: receipt_person}
	scope :state, -> (status) {where status: status}

	def self.search(search)
		where('receipt_number LIKE :search OR receipt_type LIKE :search OR receipt_person LIKE :search OR producer LIKE :search OR article LIKE :search or status LIKE :search', search: "%#{search}%")
	end

end
