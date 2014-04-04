class Product < ActiveRecord::Base
  attr_accessible :category, :description, :image_url, :make, :name, :price
   
   mount_uploader :image_url, ImageUploader#carrierwave class
   
   def self.search(search, page)#search method 
      paginate :per_page => 5, :page => page,
               :conditions => ['name like ?', "%#{search}%"], 
              :order => 'name'
   end
  #all fields validate if there is a presence ie. there are no blanks
  validates :category, presence: true, length: { maximum: 40 }#validates if string up to lenght of 40
  validates :description, presence: true
  validates :image_url, presence: true, :format => %r{\.(png|jpg|jpeg)$}i#validates file extensions so only image can be uploaded
  validates :make, presence: true, length: { maximum: 40 }
  validates :name, presence: true, length: { maximum: 40 }
  validates :price, presence: true, :numericality => {:only_float => true}#validates if the price input is a float
  end
