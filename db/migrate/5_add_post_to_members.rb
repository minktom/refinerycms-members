class AddPostToMembers < ActiveRecord::Migration

  def up
    add_column :refinery_members, :post, :string
    add_column :refinery_member_translations, :post, :string
  end

  def down
    remove_column :refinery_members, :post
    remove_column :refinery_member_translations, :post
  end

end
