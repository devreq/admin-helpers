module AdminHelpers
  mattr_accessor :config
  self.config = {
    :asset_path => "/images",
    :logo => "/images/admin/molinos.png",
    :logo_size => "104x20",
    :javascripts => ['jquery-ui', 'ckeditor/ckeditor.js', 'ckeditor/adapters/jquery', 'admin', 'jquery.ui.datepicker-ru', 'swfobject', 'ckattachments', 'jquery.form', 'jquery.editable-1.3.3.min']
  }
end