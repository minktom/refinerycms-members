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

      class << self

        def find_by_slug(slug)
          if slug.friendly_id?
            by_slug(slug).first
          else
            find(slug)
          end
        end

        def by_slug(slug, conditions={})
          locales = Refinery.i18n_enabled? ? Refinery::I18n.frontend_locales.map(&:to_s) : ::I18n.locale.to_s
          with_globalize({ :locale => locales, :slug => slug }.merge(conditions))
        end

        # Wrap up the logic of finding the pages based on the translations table.
        def with_globalize(conditions = {})
          conditions = {:locale => ::Globalize.locale.to_s}.merge(conditions)
          globalized_conditions = {}
          conditions.keys.each do |key|
            if (translated_attribute_names.map(&:to_s) | %w(locale)).include?(key.to_s)
              globalized_conditions["#{self.translation_class.table_name}.#{key}"] = conditions.delete(key)
            end
          end
          # A join implies readonly which we don't really want.
          joins(:translations).where(globalized_conditions).where(conditions).readonly(false)
        end


      end

    end
  end
end
