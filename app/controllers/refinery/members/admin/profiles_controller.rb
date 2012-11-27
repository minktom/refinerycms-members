module Refinery
  module Members
    module Admin
      class ProfilesController < ::Refinery::AdminController

        def new
          @item = Item.new
        end

        def show
          if current_refinery_user.profile
            redirect_to refinery.edit_members_admin_profile_path
            #redirect_to '/refinery/members/profile/edit'
          else
            redirect_to refinery.new_members_admin_profile_path
            #redirect_to '/refinery/members/profile/new'
          end
        end

        def edit
          @item = current_refinery_user.profile
          redirect_to(refinery.new_members_admin_profile_path) unless @item
        end

        def create
          @item = Item.new(params[:item])
          if @item.save
            redirect_to refinery.members_admin_profile_path,
                        notice: t('flash.notice.create_success', :model => Item.model_name.human, :default => 'Profile was successfully created.')
          else
            render 'refinery/members/admin/items/new'
          end
        end

        def update
          @item = current_refinery_user.profile
          if @item
            if @item.update_attributes(params[:item])
              redirect_to refinery.members_admin_profile_path,
                          notice: t('flash.notice.update_success', :model => Item.model_name.human, :default => 'Profile was successfully updated.')
            else
              render 'refinery/members/admin/items/edit'
            end
          else
            redirect_to refinery.new_members_admin_profile_path
          end
        end

        def destroy
          @item = current_refinery_user.profile
          @item.destroy
          redirect_to refinery.new_members_admin_profile_path
        end

        private


      end
    end
  end
end
