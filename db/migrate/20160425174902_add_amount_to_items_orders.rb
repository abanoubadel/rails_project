class AddAmountToItemsOrders < ActiveRecord::Migration
  def change
    add_column :items_orders, :amount, :integer
  end
end
