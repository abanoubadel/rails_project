class Group < ActiveRecord::Base
	include PublicActivity::Common
	has_and_belongs_to_many :users
	validates :name, presence: true
end
