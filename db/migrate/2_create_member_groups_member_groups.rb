class CreateMemberGroupsMemberGroups < ActiveRecord::Migration

  def up
    create_table :refinery_member_groups do |t|
      t.string :name
      t.string :slug
      t.integer :position

      t.timestamps
    end
    add_column :refinery_members, :group_id, :integer

    add_index :refinery_member_groups, :slug
    add_index :refinery_members, :group_id
  end

  def down
    remove_column :refinery_members, :group_id
    drop_table :refinery_member_groups
  end

end
