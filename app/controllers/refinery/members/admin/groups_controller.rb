module Refinery
  module Members
    module Admin
      class GroupsController < ::Refinery::AdminController

        crudify :'refinery/members/group', :order => 'position ASC',
                :title_attribute => 'name', :xhr_paging => true

      end
    end
  end
end
