module Refinery
  module Profile
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Members

      engine_name :refinery_profile

      initializer "register refinerycms_members plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "profile"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.profile_admin_profile_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/profile',
            :title => 'name'
          }
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Profile)
      end
    end
  end
end
