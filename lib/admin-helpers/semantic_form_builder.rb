require 'formtastic'

module AdminHelpers
  class SemanticFormBuilder < ::Formtastic::SemanticFormBuilder
    def attachment_input(method, options)
      style = options.delete(:style)
      after = options.delete(:after)    
      image_html = options.delete(:image_html) || {}
      html_options = options.delete(:input_html) || {}
      
      engine = options.delete(:engine) || :paperclip
      
      if engine == :paperclip          
        a = if @object.send(:"#{method}").file?
          ct = @object.send(:"#{method}_content_type")      
          if ct =~ /image/
            "<img src='#{@object.send(method).url(style)}'/>".html_safe
          else
            fn = @object.send(:"#{method}_file_name")
            fs = @object.send(:"#{method}_file_size")
            "<p class='inline-hints'>#{fn} (#{@template.number_to_human_size(fs)})</p>".html_safe
          end
        end
      elsif engine == :carrierwave
        uploader = @object.send(:"#{method}")
        a = unless uploader.file.nil?                    
          ct = uploader.respond_to?(:meta_content_type) ? uploader.meta_content_type(style) : 'image'
          if ct =~ /image/
            image_tag @object.send(method).url(style), image_html
          else
            fn = uploader.meta_filename
            fs = uploader.meta_size(style)
            "<p class='inline-hints'>#{fn} (#{@template.number_to_human_size(fs)})</p>".html_safe
          end
        end        
      end

      self.label(method, options_for_label(options)) <<
      self.file_field(method, html_options) <<
      self.hidden_field("#{method}_cache") <<
      a <<
      after
    end
  
    def tags_input(method, options)
      html_options = options.delete(:input_html) || {}
      tag_field_name = method.to_s.gsub('_list', '')
      tags_count = @object.class.send(:"#{tag_field_name}_counts")
      tags_html = tags_count.map { |t| "#{t.name} (#{t.count})"}.join(', ')
      tags_html = "<p class='inline-hints'>#{tags_html}</p>"
    
      self.label(method, options_for_label(options)) <<
      self.text_field(method, html_options) <<
      tags_html.html_safe
    end
  
    def seo_inputs(options = {})  
      self.input(:meta_title) +
      self.input(:meta_description, :input_html => {:class => "mini"}) +
      self.input(:meta_keywords).html_safe
    end
  end
end