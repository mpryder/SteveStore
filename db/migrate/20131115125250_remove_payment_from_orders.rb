class RemovePaymentFromOrders < ActiveRecord::Migration
  def up
    remove_column :orders, :payment
  end

  def down
    add_column :orders, :payment, :string
  end
end
