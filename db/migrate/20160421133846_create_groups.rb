class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.string :description
      t.string :group_image

       t.index :name, :unique => true

      t.timestamps null: false
    end
  end
end
