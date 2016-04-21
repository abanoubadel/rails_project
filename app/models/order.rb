class Order < ActiveRecord::Base
	belongs_to :restaurant
	has_many :items
	has_and_belongs_to_many :users
end
