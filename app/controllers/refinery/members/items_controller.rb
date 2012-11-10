module Refinery
  module Members
    class ItemsController < ::ApplicationController

      before_filter :find_group, only: [:show]
      before_filter :find_all_items, only: [:index]
      before_filter :find_page

      def show
        @item = Item.find_by_slug(params[:id])
        redirect_to refinery.members_groups_path unless @item

        if @item.slug && @item.slug != params[:id]
          redirect_to refinery.members_group_item_path(@item.group, @item), :status => 301
        end

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @member in the line below:
        present(@page)
      end

    protected

      def find_all_items
        @items = Item.order('position ASC')
      end

      def find_group
        @group = Group.find_by_slug(params[:group_id]) if params[:group_id]
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/members").first
      end

    end
  end
end
