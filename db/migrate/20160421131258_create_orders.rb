class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :meal
      t.integer :status
      t.string :description

      t.timestamps null: false
    end
  end
end
