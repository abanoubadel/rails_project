class AddUserIdToItemsOrders < ActiveRecord::Migration
  def change
    add_reference :items_orders, :user, index: true
    add_foreign_key :items_orders, :users
  end
end
