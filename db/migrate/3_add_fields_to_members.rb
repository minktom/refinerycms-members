class AddFieldsToMembers < ActiveRecord::Migration

  def up
    add_column :refinery_members, :post, :string
    add_column :refinery_members, :studies, :text
    add_column :refinery_members, :languages, :text
    add_column :refinery_members, :actual_education, :text
    add_column :refinery_members, :education, :text
    add_column :refinery_members, :research, :text
    add_column :refinery_members, :conferences, :text
    add_column :refinery_members, :publications, :text
    add_column :refinery_members, :awards, :text
  end

  def down
    remove_column :refinery_members, :post
    remove_column :refinery_members, :studies
    remove_column :refinery_members, :languages
    remove_column :refinery_members, :actual_education
    remove_column :refinery_members, :education
    remove_column :refinery_members, :research
    remove_column :refinery_members, :conferences
    remove_column :refinery_members, :publications
    remove_column :refinery_members, :awards
  end

end
