class AddIdToItemsOrders < ActiveRecord::Migration
  def change
    add_column :items_orders, :id, :primary_key
  end
end
