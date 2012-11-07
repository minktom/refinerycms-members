module Refinery
  module Members
    class Group < Refinery::Core::BaseModel
      self.table_name = 'refinery_member_groups'

      extend FriendlyId
      friendly_id :name, :use => [:slugged]
      translates :name, :slug

      class Translation
        attr_accessible :locale
      end

      has_many    :items
      
      attr_accessible :name, :position

      acts_as_indexed :fields => [:name]

      validates :name, :presence => true, :uniqueness => true
    end
  end
end
