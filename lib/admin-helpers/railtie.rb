module AdminHelpers
  class Railtie < ::Rails::Engine
    paths.app << "app"    

    config.action_view.javascript_expansions[:admin] = AdminHelpers.config[:javascripts]

    initializer "static assets" do |app|
      app.middleware.use ::ActionDispatch::Static, "#{root}/public"
    end

    initializer "admin-helpers.on_controller" do |app|    
      ActiveSupport.on_load :action_controller do
        ActionController::Base.helper(AdminHelpers::Helper)      
        ActionController::Base.helper(AdminHelpers::Jquery)
      end  
    end    
  end
end