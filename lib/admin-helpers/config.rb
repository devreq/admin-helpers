module AdminHelpers
  mattr_accessor :config
  self.config = {
    :asset_path => "/images"
  }
end