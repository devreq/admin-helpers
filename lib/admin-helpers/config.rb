module AdminHelpers
  mattr_accessor :config
  self.config = {
    :logo => "/images/admin/molinos.png",
    :logo_size => "104x20",    
    :ckeditor_js => ['ckeditor/ckeditor.js', 'ckeditor/adapters/jquery']
  }
end