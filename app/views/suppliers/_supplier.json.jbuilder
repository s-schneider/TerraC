json.extract! supplier, :id, :name, :delilver_cond, :payment_cond, :reorder_cond, :preorder_cond, :created_at, :updated_at
json.url supplier_url(supplier, format: :json)