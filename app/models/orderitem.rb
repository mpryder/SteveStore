class Orderitem < ActiveRecord::Base
  belongs_to :order
  attr_accessible :description, :name, :price, :product_id, :quantity, :order_id
end
