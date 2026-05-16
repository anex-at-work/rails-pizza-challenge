module Discounts
  class Deduction
    def initialize(policy:)
      @policy = policy
    end

    def call(price:)
      price * (100 - @policy[:deduction_in_percent]) / 100
    end
  end
end
