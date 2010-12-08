begin
  require "bundler"
  Bundler.setup
rescue Bundler::GemNotFound
  raise RuntimeError, "Bundler couldn't find some gems." +
    "Did you run `bundle install`?"
end

Bundler.require

module AdminHelpers
  require 'admin-helpers/config'    
  require 'admin-helpers/helper'
  require 'admin-helpers/batch_action'
  require 'admin-helpers/semantic_form_builder'
  require 'admin-helpers/railtie' if defined?(Rails)
end