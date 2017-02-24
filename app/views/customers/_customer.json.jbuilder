json.extract! customer, :id, :customer_name, :customer_street, :customer_town, :customer_phone, :customer_email, :created_at, :updated_at
json.url customer_url(customer, format: :json)