class Restaurant < ActiveRecord::Base
	#has_many :orders
	has_attached_file :menu_image, :styles => { :medium => "238x238>",
																			 :thumb => "100x100>"
	}
  validates_attachment_content_type :menu_image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
	has_many :items


end
