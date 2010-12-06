module AdminHelpers
  class Railtie < ::Rails::Engine
    paths.app << "app"    
    config.asset_path = "/admin/%s"

    config.action_view.javascript_expansions[:admin] = AdminHelpers.config[:javascripts]

    initializer "admin-helpers.on_controller" do |app|    
      ActiveSupport.on_load :action_controller do
        ActionController::Base.helper(AdminHelpers::Helper)      
      end  
    end
    
#    rake_tasks do
#      load "admin-helpers.tasks"
#    end    
  end
end