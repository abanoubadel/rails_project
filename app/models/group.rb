class Group < ActiveRecord::Base
	include PublicActivity::Common
	has_and_belongs_to_many :users
	validates :name, presence: true, uniqueness: { case_sensitive: false }
	after_create do |group|
    	puts "Group Created"
  	end
end
