class Order < ActiveRecord::Base
	belongs_to :restaurant
  has_many :items_orders
	has_and_belongs_to_many :users
  has_and_belongs_to_many :items
  belongs_to :owner, :class_name => "User",foreign_key: :owner_id
end
