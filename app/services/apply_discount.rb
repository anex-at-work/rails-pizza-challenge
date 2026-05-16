class ApplyDiscount
  def initialize(discounts: {
      "SAVE5" => Discounts::Deduction.new(policy: {
        deduction_in_percent: 5
      })
    }
  )
    @discounts = discounts
  end

  def call(price:, discount_code:)
    raise ArgumentError, "Unknown discount code: #{discount_code}" unless @discounts.key?(discount_code)

    @discounts[discount_code].call(price:)
  end
end
