module ApplicationHelper

  # Generates a <i> tag with the appropriate Font Awesome icon code class
  # @param [String] klazz The icon FA class
  # @param [Colour] colour The icon colour
  # @param [Hash] options
  def icon(klazz, colour = nil, options = {})
    icon_class = "fal fa-#{klazz}"
    icon_class << " icon-white" if colour == :white
    content_tag :i, nil, options.merge(class: "#{icon_class} #{options[:class]}")
  end

  # Generates a table for a collection of active record objects showing a list
  # of its attributes. The last column in the table will have a set of buttons
  # (edit, destroy and show). Pagination is at the top and at the bottom of the
  # table.
  #
  # @param [Array] collection A collection of ActiveRecord objects.
  # @param [Hash] options A list of options including DOM id, partial to use or the model class (to use with arrays insetad of AR collections)
  # @param [Array] attr_list A list of the attributes to be shown.
  # @return [HTML] A table to show the paginated collection of objects.
  def table_for(collection, options = {}, *attr_list)
    actions = false
    classes = options[:classes] || ""
    model_class_name = options[:model_name] || collection.name
    table_id = options[:id] || model_class_name.tableize
    table_klazz = model_class_name.constantize
    table_headers = []

    attr_list.flatten.each do |attr_name|
      if attr_name.class == Hash && !attr_name[:actions].nil?
        actions = attr_name[:actions]
      else
        header_content = table_klazz.human_attribute_name(attr_name)
        header = content_tag(:th, header_content)
        table_headers << header
      end
    end

    if actions
      table_headers << content_tag(:th, t('actions'), class: 'table_actions')
    end

    thead = content_tag :thead, content_tag(:tr, table_headers.join(" ").html_safe)
    table_content = ""
    if options[:partial].present?
      table_content = render partial: options[:partial], collection: collection
    else
      table_content = render collection
    end
    tbody = content_tag :tbody, table_content
    table = content_tag(:table, "#{thead} #{tbody}".html_safe, id: table_id, class: "table table-hover #{classes}")
    table.html_safe
  end

  def render_flash(source = flash)
    source.map do |name, msg|
      next if msg.empty?

      content_tag :div, id: 'error_messages', class: "flash alert #{bootstrap_class_for_flash(name)} fade show", 'data-alert' => 'true' do
        content = []
        content << link_to('&times;'.html_safe, '#', class: 'close', :"data-dismiss" => 'alert')
        content << msg
        content.join('').html_safe
      end
    end.join('').html_safe
  end

  def bootstrap_class_for_flash(flash_type)
    case flash_type
    when 'success'
      'alert-success'
    when 'error'
      'alert-danger'
    when 'alert'
      'alert-warning'
    when 'notice'
      'alert-info'
    else
      flash_type.to_s
    end
  end
end
