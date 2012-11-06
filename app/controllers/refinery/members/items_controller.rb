module Refinery
  module Members
    class ItemsController < ::ApplicationController

      before_filter :find_all_items
      before_filter :find_page

      def show
        @item = Item.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @member in the line below:
        present(@page)
      end

    protected

      def find_all_items
        @items = Item.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/members").first
      end

    end
  end
end
