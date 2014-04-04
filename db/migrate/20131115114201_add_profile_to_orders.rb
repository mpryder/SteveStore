class AddProfileToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :firstname, :string
    add_column :orders, :lastname, :string
    add_column :orders, :address, :string
    add_column :orders, :mobile, :integer
    add_column :orders, :payment, :string
  end
end
