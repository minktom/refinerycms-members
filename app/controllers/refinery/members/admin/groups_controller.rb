module Refinery
  module Members
    module Admin
      class GroupsController < ::Refinery::AdminController

        crudify :'refinery/members/group', :order => 'position ASC',
                :title_attribute => 'name', :xhr_paging => true

        private

        def find_group
          @group = Group.find_by_slug(params[:id])
        end

      end
    end
  end
end
