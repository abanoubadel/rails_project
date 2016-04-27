class AddGroupAdminIdToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :group_admin_id, :integer, :null => false
  end
end
