module AdminHelpers
  module Jquery
    def jq_dialog(content, *args)
      options = args.extract_options!
      options.reverse_merge!(:width => "60%", :height => 'auto', :modal => true)
      %{
        if ($('#dialog').length == 0) {
          $('body').append('<div id="dialog"></div>');
        }
        $('#dialog').
          html('#{escape_javascript(content)}').
          dialog(#{options.to_json});
      }.html_safe
    end
    
    def jq_close_dialog
      %{
        $('#dialog').dialog('close').dialog('destroy');
      }
    end
  
    def js_redirect_to(url)
      "document.location = '#{url}';".html_safe
    end
  
    def jq_replace_with(s, content)
      "$('#{s}').replaceWith('#{escape_javascript(content)}');".html_safe
    end
  
    def jq_html(s, content)
      "$('#{s}').html('#{escape_javascript(content)}');".html_safe
    end
  end
end