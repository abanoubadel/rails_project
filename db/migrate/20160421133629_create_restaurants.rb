class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :menu_image
      t.string :phone
      t.string :location

      t.timestamps null: false
    end
  end
end
