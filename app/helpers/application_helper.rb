module ApplicationHelper
  def render_flash_messages
    flash.map do |key, value|
      content_tag(:div, class: key) do
        value
      end
    end.join
  end
end
