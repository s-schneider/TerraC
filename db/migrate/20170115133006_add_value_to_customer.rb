class AddValueToCustomer < ActiveRecord::Migration[5.0]
  def change
    add_column :customers, :customer_group, :string
  end
end
