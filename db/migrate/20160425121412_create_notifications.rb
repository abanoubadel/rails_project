class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.belongs_to :user, index: true
      t.belongs_to :activity
      t.boolean :status

      t.timestamps null: false
    end

    add_index :notifications, :activity_id
  end
end