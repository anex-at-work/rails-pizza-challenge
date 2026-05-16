module Promotions
  class NForK
    def initialize(policy:)
      @policy = policy
    end

    def call(order:)
      filtered = order.order_pizzas.filter { |op| op.pizza.name == @policy[:target] && op.size == @policy[:target_size] }
      filtered = filtered.drop(filtered.size / @policy[:from] * @policy[:to])
      order.order_pizzas = order.order_pizzas - filtered
      order
    end
  end
end
