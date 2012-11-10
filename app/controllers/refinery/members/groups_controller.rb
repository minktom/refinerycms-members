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
        @group = Group.find_by_slug(params[:id])
        redirect_to refinery.members_groups_path unless @group

        if @group.slug && @group.slug != params[:id]
          redirect_to refinery.members_group_path(@group), :status => 301
        end

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @member_group in the line below:
        present(@page)
      end

    protected

      def find_all_groups
        @groups = Group.includes(:items).order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/members").first
      end

    end
  end
end
