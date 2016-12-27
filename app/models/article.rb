class Article < ApplicationRecord
	has_many :receipts


	def self.search(search)
		where('article_name LIKE :search OR article_producer LIKE :search OR article_color LIKE :search OR article_size LIKE :search', search: "%#{search}%")
	end
end
