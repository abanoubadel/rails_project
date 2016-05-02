class Group < ActiveRecord::Base
	include PublicActivity::Common
	has_and_belongs_to_many :users
	validates :name, presence: true, uniqueness: { case_sensitive: false }
	has_attached_file :image
  	validates_attachment :image,
                     content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }
end
