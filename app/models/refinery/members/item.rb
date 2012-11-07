module Refinery
  module Members
    class Item < Refinery::Core::BaseModel
      self.table_name = 'refinery_members'

      extend FriendlyId
      friendly_id :name, :use => [:slugged]

      translates :name, :slug, :post, :address, :room, :studies, :languages, :education, :research, :conferences, :publications, :awards

      class Translation
        attr_accessible :locale
      end

      belongs_to :group

      attr_accessible :name, :post, :position, :avatar_id, :group_id,
        :address, :room, :email, :phone, :fax, :born_at, :born_in,
        :studies, :languages, :education, :research, :conferences, :publications, :awards

      acts_as_indexed :fields => [:name, :post, :address, :room, :email, :phone, :fax, :born_in,
        :studies, :languages, :education, :research, :conferences, :publications, :awards]

      validates :name, :presence => true, :uniqueness => true
      validates :group_id, :presence => true

      default_scope order('position ASC')

      belongs_to :avatar, :class_name => '::Refinery::Image'
    end
  end
end
