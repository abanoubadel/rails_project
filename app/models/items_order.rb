class ItemsOrder < ActiveRecord::Base
  belongs_to :item , class_name: 'Item'
  belongs_to :order, class_name: 'Order'
end
