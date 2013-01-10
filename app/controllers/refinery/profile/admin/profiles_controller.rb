module Refinery
  module Profile
    module Admin
      class ProfilesController < ::Refinery::AdminController

        def new
          @item = Refinery::Members::Item.new
        end

        def show
          if current_refinery_user.profile
            redirect_to refinery.edit_profile_admin_profile_path
          else
            redirect_to refinery.new_profile_admin_profile_path
          end
        end

        def edit
          @item = current_refinery_user.profile
          redirect_to(refinery.new_profile_admin_profile_path) unless @item
        end

        def create
          @item = current_refinery_user.build_profile(params[:item])
          if @item.save
            redirect_to refinery.profile_admin_profile_path,
                        notice: t('flash.notice.create_success', :model => Refinery::Members::Item.model_name.human, :default => 'Profile was successfully created.')
          else
            render 'refinery/members/admin/items/new'
          end
        end

        def update
          @item = current_refinery_user.profile
          if @item
            if @item.update_attributes(params[:item])
              redirect_to refinery.profile_admin_profile_path,
                          notice: t('flash.notice.update_success', :model => Refinery::Members::Item.model_name.human, :default => 'Profile was successfully updated.')
            else
              render 'refinery/members/admin/items/edit'
            end
          else
            redirect_to refinery.new_profile_admin_profile_path
          end
        end

        def destroy
          @item = current_refinery_user.profile
          @item.destroy
          redirect_to refinery.new_profile_admin_profile_path
        end

        private


      end
    end
  end
end
