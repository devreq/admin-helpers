module AdminHelpers
  mattr_accessor :config
  self.config = {
    :logo => "/images/admin/molinos.png",
    :logo_size => "104x20",
    :javascripts => ['jquery-ui', 'ckeditor/ckeditor.js', 'ckeditor/adapters/jquery', 'admin', 'jquery.ui.datepicker-ru', 'jquery.form']
  }
end