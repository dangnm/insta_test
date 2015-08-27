class AddAvatarToUsers < ActiveRecord::Migration
  def change
    add_column :users, :avatar, :oid, :null => true
  end
end
