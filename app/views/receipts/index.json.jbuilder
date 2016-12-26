json.array!(@receipts) do |receipt|
  json.extract! receipt, :id, :type
  json.url receipt_url(receipt, format: :json)
end