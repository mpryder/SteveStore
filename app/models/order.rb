class Order < ActiveRecord::Base
  belongs_to :user
  attr_accessible :order_date, :user_id, :firstname, :lastname, :address, :mobile, :order_id
  has_many :orderitems
end
