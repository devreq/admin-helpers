module AdminHelpers
  require 'admin-helpers/config'    
  require 'admin-helpers/batch_action'
  require 'admin-helpers/semantic_form_builder'
  require 'admin-helpers/admin'
  require 'admin-helpers/jquery'  
  require 'admin-helpers/swfupload'    
  require 'admin-helpers/railtie' if defined?(Rails)
end