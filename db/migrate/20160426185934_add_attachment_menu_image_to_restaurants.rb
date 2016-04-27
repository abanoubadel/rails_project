class AddAttachmentMenuImageToRestaurants < ActiveRecord::Migration
  def self.up
    change_table :restaurants do |t|
      t.attachment :menu_image
    end
  end

  def self.down
    remove_attachment :restaurants, :menu_image
  end
end
