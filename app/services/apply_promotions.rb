class ApplyPromotions
  def initialize(promotions: {
      "2FOR1" => Promotions::NForK.new(policy: {
        target: "Salami",
        target_size: "small",
        from: 2,
        to: 1
      })
    }
  )
    @promotions = promotions
  end

  def call(order:)
    ret = order.dup
    ret.order_pizzas = order.order_pizzas.dup

    order.promotions.each do |promotion|
      raise ArgumentError, "Unknown promotion: #{promotion}" unless @promotions.key?(promotion)

      ret = @promotions[promotion].call(order: ret)
    end
    ret
  end
end
