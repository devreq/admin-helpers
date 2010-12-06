module AdminHelpers
  class Railtie < ::Rails::Engine
    paths.app << "app"    
    initializer "admin_helpers.on_controller" do |app|    
      ActiveSupport.on_load :action_controller do
        ActionController::Base.helper(AdminHelpers::Helper)      
      end  
    end
  end
end