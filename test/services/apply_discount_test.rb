require "test_helper"

class ApplyDiscountTest < ActiveSupport::TestCase
  test "should raise an error for unknown promotion" do
    assert_raises(ArgumentError) do
      ApplyDiscount.new.call(price: 100, discount_code: "UNKNOWN")
    end
  end

  test "should apply discount for SAVE5 promotion" do
    price = ApplyDiscount.new.call(price: 100, discount_code: "SAVE5")
    assert_equal 95, price
  end
end
