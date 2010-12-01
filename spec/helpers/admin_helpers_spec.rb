require 'spec_helper'

describe AdminHelpers::Helper do
  before(:each) do
    controller.controller_path = 'foos'
    controller.action_name = 'bar'    
  end

  it "admin_icon" do
    helper.admin_icon("test", :width => 16).should match(/img/)
  end

  it "admin_table" do
    proc { helper.admin_table("test") { "" } }.should_not raise_error
  end
end