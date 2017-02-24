json.extract! receipt, :id, :receipt_number, :receipt_type, :receipt_person, :receipt_date, :receipt_notes, :created_at, :updated_at
json.url receipt_url(receipt, format: :json)