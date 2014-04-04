class Profile < ActiveRecord::Base
  
  belongs_to :user
  attr_accessible :address, :firstname, :lastname, :mobile, :user_id
  
  validates :address, presence: true#validates if data is entered
  validates :firstname, presence: true, length: { maximum: 40 }#validates if data length, including spaces, is under 40  
  validates :lastname, presence: true, length: { maximum: 40 }
  validates :mobile, presence: true, :numericality => {:only_integer => true}#validats if an integer is entered
  
  
 
end
