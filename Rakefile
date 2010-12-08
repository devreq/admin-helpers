# encoding: UTF-8
require 'rake'
require 'rspec/core'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)
task :default => :spec

begin
  require "jeweler"
  Jeweler::Tasks.new do |gem|
    gem.name = "admin-helpers"
    gem.summary = "Helpers for rockbee/molinos admin panels"
    gem.description = "Helpers for rockbee/molinos admin panels"
    gem.files =  FileList["[A-Z]*", "lib/**/*"]
    gem.version = "0.0.2"
    gem.email = "gzigzigzeo@gmail.com"
    gem.authors = ["Victor Sokolov"]
    gem.homepage = "http://studio.molinos.ru"
            
    gem.add_dependency "rails", ">= 3.0.0"    
    gem.add_dependency "formtastic"
  end
  
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end