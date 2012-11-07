class TranslateMembers < ActiveRecord::Migration

  def up
    ::Refinery::Members::Group.reset_column_information
    unless defined?(::Refinery::Members::Group::Translation) && ::Refinery::Members::Group::Translation.table_exists?
      ::Refinery::Members::Group.create_translation_table!({
        :name => :string
      }, {:migrate_data => true})
    end
    
    ::Refinery::Members::Item.reset_column_information
    unless defined?(::Refinery::Members::Item::Translation) && ::Refinery::Members::Item::Translation.table_exists?
      ::Refinery::Members::Item.create_translation_table!({
        :name => :string,
        :post => :string,
        :address => :string,
        :room => :string,
        :studies => :text,
        :languages => :text,
        :education => :text,
        :research => :text,
        :conferences => :text,
        :publications => :text,
        :awards => :text
      }, {:migrate_data => true})
    end

  end

  def down
    ::Refinery::Members::Group.reset_column_information
    ::Refinery::Members::Group.drop_translation_table!

    ::Refinery::Members::Item.reset_column_information
    ::Refinery::Members::Item.drop_translation_table!
  end

end