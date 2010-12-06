module AdminHelpers
  module Helper
    def admin_icon(id, *args)
      image_tag("/images/admin/icons/#{id.to_s}.png", *args)
    end

    def admin_nav_link(key, url, active, chosen = nil)
      label = I18n.t(:"admin.navigation.#{key}")
      stateful_link_to(
        active,
        chosen,
        :active => "<li class='active'>#{label}</li>", 
        :inactive => "<li>#{link_to label, url}</li>",
        :chosen => "<li class='chosen'>#{link_to label, url}</li>"  
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
        o = options.reverse_merge(:id => "#{current_model.name.underscore}_#{id}", :rel => r[:id])
        b = capture(r, &block)
        content_tag :tr, b, o
      end
      rows.join.html_safe
    end

    def admin_edit_link(o, *args)
      options = args.extract_options!
      options.reverse_merge!(:title => I18n.t("admin.alts.edit"))
      link_to admin_icon(:edit), polymorphic_path([:admin, o], :action => :edit), options
    end

    def admin_destroy_link(o, *args)
      options = args.extract_options!
      options.reverse_merge!(
        :title => I18n.t("admin.alts.destroy"),
        :method => :delete,
        :confirm => I18n.t("admin.confirmations.destroy.#{current_model.name.underscore}")
      )
      link_to admin_icon(:delete), polymorphic_path([:admin, o]), options
    end

    def admin_filter_link(label, link, &block)
      stateful_link_to(
        :active => label, 
        :inactive => link,
        :state => block
      )
    end

    def admin_cb(o)
      check_box_tag "ids[]", o.id
    end

    def admin_move_icon(title)
      admin_icon(:move, :class => "move", :alt => I18n.t("admin.alts.move"), :rel => title)
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

    def admin_delete_batch_button
      submit_tag "Удалить", :name => :destroy, :confirm => I18n.t(:"admin.confirmations.delete.#{current_model.name.underscore}")
    end

    def admin_publish_and_unpublish_batch_button
      submit_tag("Опубликовать", :name => :publish) + " ".html_safe +
      submit_tag("Снять с публикации", :name => :unpublish)
    end

    def admin_help_link
      %{<a href="#" title="Помощь" id="help_icon"><img src="/images/icons/info.png" width="16" height="16" alt="Помощь"/></a>}.html_safe
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