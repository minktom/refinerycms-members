module Refinery
  module Members
    module Admin
      class ItemsController < ::Refinery::AdminController

        crudify :'refinery/members/item', :order => 'position ASC',
                :title_attribute => 'name', :xhr_paging => true

        before_filter :find_group, :only => [:index]

        def index
          if params[:group_id]
            @items = @group.items.order('position ASC')
          else
            redirect_to refinery.members_admin_groups_path and return
          end

          @items = @items.page(params[:page])
        end

        def new
          @item = Item.new(:group_id => find_group)
        end

        private

        def find_group
          @group = Group.find_by_slug(params[:group_id]) if params[:group_id]
        end

      end
    end
  end
end
