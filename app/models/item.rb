class Item < ActiveRecord::Base
	belongs_to :restaurant
  has_many :items_orders
	has_many :orders,:through => :items_orders
	#has_many :orders
	has_attached_file :image, :styles => { :medium => "140x100>",
																							:thumb => "50x50>"
	}
	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
	has_many :items

end

