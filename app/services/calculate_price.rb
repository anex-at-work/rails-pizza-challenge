class CalculatePrice
  PIPELINE_METHODS = %i[
    additional_ingredients_price
    apply_promotions
    price_per_pizza
    apply_discount
  ].freeze
  private_constant :PIPELINE_METHODS

  def call(order:)
    price = 0
    PIPELINE_METHODS.each do |pipeline_method|
      order, price = send(pipeline_method, order:, price:)
    end
    price
  end

  private
  def additional_ingredients_price(order:, price:)
    delta = order.order_pizzas.sum do |order_pizza|
      next 0 if order_pizza.add.nil?

      order_pizza.add.map { |a| a["price"] }.sum * order_pizza.size_multiplier
    end

    [ order, price + delta ]
  end

  def apply_promotions(order:, price:)
    [ ApplyPromotions.new.call(order:), price ]
  end

  def price_per_pizza(order:, price:)
    delta = order.order_pizzas.sum do |order_pizza|
      order_pizza.pizza.price * order_pizza.size_multiplier
    end

    [ order, price + delta ]
  end

  def apply_discount(order:, price:)
    return [ order, price ] unless order.discount.present?

    [ order, ApplyDiscount.new.call(price:, discount_code: order.discount) ]
  end
end
