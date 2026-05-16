class CalculatePrice
  PIPELINE_METHODS = %i[additional_ingredients_price price_per_pizza].freeze
  private_constant :PIPELINE_METHODS

  def call(order:)
    price = 0
    PIPELINE_METHODS.each do |pipeline_method|
      price += send(pipeline_method, order)
    end
    price
  end

  private
  def additional_ingredients_price(order)
    order.order_pizzas.sum do |order_pizza|
      order_pizza.add.map { |a| a["price"] }.sum * order_pizza.size_multiplier
    end
  end

  def price_per_pizza(order)
    order.order_pizzas.sum do |order_pizza|
      order_pizza.pizza.price * order_pizza.size_multiplier
    end
  end
end
