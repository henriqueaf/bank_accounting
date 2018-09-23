module ApplicationHelper
  def render_flash_messages
    flash.map do |key, value|
      content_tag(:div, class: "alert alert-#{key} alert-dismissible fade show", role: "alert") do
        content_tag(:font, value) +
        content_tag(:button, class: "close", "data-dismiss" => "alert", "aria-label" => "Close") do
          content_tag(:span, "&times;".html_safe, "aria-hidden" => "true")
        end
      end
    end.join.html_safe
  end
end
