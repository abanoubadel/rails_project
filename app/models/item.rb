class Item < ActiveRecord::Base
	belongs_to :restaurant
  has_many :items_orders
	has_many :orders,:through => :items_orders
end

