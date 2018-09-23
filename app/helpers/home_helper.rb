module HomeHelper
  def display_amount(amount)
    additional_class = amount > 0 ? 'text-success' : 'text-danger'

    content_tag(:h1, class: "display-4 pb-0 mb-0 #{additional_class}") do
      number_to_currency(amount)
    end
  end

  def display_transference_list_item(transference)
    additional_class, icon_name = if transference.value > 0
      ['text-success', 'plus']
    else
      ['text-danger', 'minus']
    end

    content_tag(:li, class: "list-group-item #{additional_class}") do
      content_tag(:font, number_to_currency(transference.value)) +
      fa_icon(icon_name, class: "pull-right")
    end
  end
end
