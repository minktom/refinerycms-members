class AddUserIdToMembers < ActiveRecord::Migration

  def up
    add_column :refinery_members, :user_id, :integer
  end

  def down
    remove_column :refinery_members, :user_id
  end

end
