module Refinery
  module Members
    class GroupsController < ::ApplicationController

      before_filter :find_all_groups
      before_filter :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @member_group in the line below:
        present(@page)
      end

      def show
        @group = Group.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @member_group in the line below:
        present(@page)
      end

    protected

      def find_all_groups
        @groups = Group.includes(:items).order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/groups").first
      end

    end
  end
end
