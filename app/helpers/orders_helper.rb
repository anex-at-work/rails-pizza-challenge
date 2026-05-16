module OrdersHelper
  def format_price(price)
    ActiveSupport::NumberHelper.number_to_currency(price / 100.0, unit: "€")
  end

  def format_codes(codes, filler: " - ")
    return filler unless codes.present?

    codes.is_a?(Array) ? codes.join(", ") : codes.presence
  end
end
