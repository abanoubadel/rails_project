class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.integer :amount
      t.float :price
      t.string :comment
      t.string :image

      t.timestamps null: false
    end
  end
end
