class CalculatePrice
  PIPELINE_METHODS = %i[
    additional_ingredients_price
    apply_promotions
    price_per_pizza].freeze
  private_constant :PIPELINE_METHODS

  def call(order:)
    price = 0
    PIPELINE_METHODS.each do |pipeline_method|
      order, delta = send(pipeline_method, order)
      price += delta
    end
    price
  end

  private
  def additional_ingredients_price(order)
    delta = order.order_pizzas.sum do |order_pizza|
      order_pizza.add.map { |a| a["price"] }.sum * order_pizza.size_multiplier
    end

    [ order, delta ]
  end

  def apply_promotions(order)
    [ ApplyPromotions.new.call(order:), 0 ]
  end

  def price_per_pizza(order)
    delta = order.order_pizzas.sum do |order_pizza|
      order_pizza.pizza.price * order_pizza.size_multiplier
    end

    [ order, delta ]
  end
end
