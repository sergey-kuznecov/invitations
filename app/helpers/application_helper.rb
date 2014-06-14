module ApplicationHelper
  def bootstrap_flash
    flash_messages = []
    flash.each do |type, message|
      next if message.blank?
      type = :success if type == :notice
      type = :danger   if type == :alert
      text = content_tag(:div,
                         content_tag(:button, raw('&times;'),  class: 'close', 'data-dismiss' => 'alert') +
                             message, :class => "alert fade in alert-#{type}")
      flash_messages << text if message
    end
    flash_messages.join("\n").html_safe
  end

  def widget_box(title, icon_class='icon-th', &block)

    content_tag('div', class: 'widget-box') do
      (content_tag('div', class: 'widget-title') do
        (content_tag('span', class: 'icon') do
          content_tag('i', '', class: icon_class )
        end)+

            content_tag(:h5, title.html_safe)
      end)+

          content_tag('div', class: 'widget-content') do
            yield(block)
          end

    end.html_safe
  end
end
