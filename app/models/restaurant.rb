class Restaurant < ActiveRecord::Base
  require 'models_helpers'
  include ModelsHelpers

  ########################## paper clips config  ##############################

	has_attached_file :menu_image, :styles => { :medium => "600x300>",
																			 :thumb => "200x100>"
	}
	has_attached_file :logo, { :medium => "238x238>",
														 :thumb => "100x100>"}

  validates_attachment_content_type :menu_image, :content_type => ModelsHelpers.images_types
	validates_attachment_content_type :logo, :content_type => ModelsHelpers.images_types

	############################ Relations ######################################

	#has_many :orders
	has_many :items


end
