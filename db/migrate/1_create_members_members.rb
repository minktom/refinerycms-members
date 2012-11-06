class CreateMembersMembers < ActiveRecord::Migration

  def up
    create_table :refinery_members do |t|
      t.string :name
      t.string :slug
      t.integer :avatar_id
      t.string :address
      t.string :room
      t.string :email
      t.string :phone
      t.string :fax
      t.datetime :born_at
      t.string :born_in
      t.integer :position

      t.timestamps
    end
    add_index :refinery_members, :slug
  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-members"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/members/members"})
    end

    drop_table :refinery_members

  end

end
