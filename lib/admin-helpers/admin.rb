module AdminHelpers
  module Helper
    def admin_title
      parts = []
      parts << I18n.t("admin.headings.#{current_model.name.underscore}.#{controller.action_name.underscore}") rescue nil
      parts << I18n.t("admin.title") 
      parts.join(' - ').html_safe
    end
    
    def admin_icon(id, *args)
      image_tag("/images/admin/icons/#{id.to_s}.png", *args)
    end

    def admin_nav_link(key, url, active, chosen = nil, *args)
      options = args.extract_options!
      label = options.delete(:label) || I18n.t(:"admin.navigation.#{key}")

      o = {
        :active => "<li class='active'>#{label}</li>", 
        :inactive => "<li>#{link_to label, url}</li>",
        :chosen => "<li class='chosen'>#{link_to label, url}</li>"        
      }.merge(options)
            
      stateful_link_to(
        active,
        chosen,
        o
      ).html_safe
    end

    def admin_heading_content
      I18n.t("admin.headings.#{admin_locale_key}")
    end

    def admin_heading
      content_tag :h1, admin_heading_content
    end

    def admin_table(*args, &block)
      options = args.extract_options!
      options.reverse_merge!(:class => "list")
      content_tag :table, capture(&block), options
    end

    def admin_th(a, *args)
      m = current_model.name.singularize.underscore.to_sym
      options = args.extract_options!
      label = options.delete(:label) || I18n.t(
        :"formtastic.labels.#{m}.#{a}",
        :default => [:"formtastic.labels.#{a.to_s}"]
      )      
      content_tag :th, label, options
    end

    def admin_tr(*args, &block)
      options = args.extract_options!
      rows = options.delete(:rows) || current_objects
      rows = rows.map do |r|
        o = options.reverse_merge(:id => "#{current_model.name.underscore}_#{r.id}", :rel => r.id)
        b = capture(r, &block)
        content_tag :tr, b, o
      end
      rows.join.html_safe
    end

    def admin_edit_link(o, *args)
      options = args.extract_options!
      url = options.delete(:url)
      options.reverse_merge!(:title => I18n.t("admin.labels.edit"))    
      link_to admin_icon(:edit), url || polymorphic_path([:admin, o], :action => :edit), options
    end

    def admin_destroy_link(o, *args)
      options = args.extract_options!
      url = options.delete(:url)      
      options.reverse_merge!(
        :title => I18n.t("admin.labels.destroy"),
        :method => :delete,
        :confirm => I18n.t("admin.confirmations.destroy.#{current_model.name.underscore}")
      )
      link_to admin_icon(:delete), url || polymorphic_path([:admin, o]), options
    end

    def admin_filter(label = nil, &block)
      content_tag :div, :class => "filter" do
        content_tag :ul do
          html = []
          html << "<li><b>#{label}</b></li>".html_safe if label
          html << capture(&block)
          html.join.html_safe
        end
      end
    end

    def admin_filter_link(label, link, &block)
      stateful_link_to(
        :active => label, 
        :inactive => link_to(label, link),
        :state => block
      )
    end

    def admin_cb(o)
      check_box_tag "ids[]", o.id
    end

    def admin_move_icon(title)
      admin_icon(:move, :class => "move", :alt => I18n.t("admin.labels.move"), :rel => title)
    end

    def admin_nav_exit_link
      content_tag :li, :class => "r" do
        form_tag admin_logout_path, :method => :delete, :style => "display: inline;" do
          link_to "Выйти", admin_logout_path, :class => "-submit-form" +
          "<noscript>#{submit_tag "Выйти"}</noscript>"
        end
      end
    end

    def admin_nav_site_link
      "<li class='r'>#{link_to "Перейти на сайт", "/"}</li>".html_safe
    end    

    def admin_batch_button(key,  *args)
      options = args.extract_options!
      label = options.delete(:label) || I18n.t(:"admin.labels.#{key}")
      name = options.delete(:name) || key
      confirm = options.delete(:confirm)
      confirm = I18n.t(:"admin.confirmations.delete.#{current_model.name.underscore}") if confirm == true
      submit_tag label, :name => name, :confirm => confirm
    end

    def admin_help_link
      %{<a href="#" title="Помощь" id="help_icon">#{admin_icon(:info)}</a>}.html_safe
    end    

    def admin_help(title, &block)
      %{
        <div id="help" title="#{title}">#{capture(&block)}</div>
      }.html_safe
    end
    
    private
    def admin_locale_key
      "#{current_model.name.singularize.underscore}.#{controller.action_name.underscore}"
    end
  end
end