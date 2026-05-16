require "test_helper"

class CalculatePriceTest < ActiveSupport::TestCase
  test "should summ all prizes regarding multipliers for simple order without discount and promotions" do
    order = FactoryBot.create(:order, order_pizzas_count: 0, with_discount: false, with_promotions: false)
    pizza = FactoryBot.create(:pizza, price: 100)
    order.order_pizzas = [
      FactoryBot.create(:order_pizza, order: order, size_multiplier: 1.0, pizza:, add: []),
      FactoryBot.create(:order_pizza, order: order, size_multiplier: 1.5, pizza:, add: [])
  ]
    price = CalculatePrice.new.call(order:)

    assert_equal 250, price
  end

  test "should not affect price for order with removed ingredients" do
    order = FactoryBot.create(:order, order_pizzas_count: 0, with_discount: false, with_promotions: false)
    pizza = FactoryBot.create(:pizza, price: 100)
    order.order_pizzas = [ FactoryBot.create(:order_pizza, order: order, size_multiplier: 1.0, pizza:, add: [], remove: [ { name: "Onions", price: 100 } ]) ]
    price = CalculatePrice.new.call(order:)

    assert_equal 100, price
  end

  test "should add ingredients prices regarding multiplier for order with add ingredients" do
    order = FactoryBot.create(:order, order_pizzas_count: 0, with_discount: false, with_promotions: false)
    pizza = FactoryBot.create(:pizza, price: 100)
    order.order_pizzas = [ FactoryBot.create(:order_pizza, order: order, size_multiplier: 1.5, pizza:, add: [ { name: "Onions", price: 100 } ]) ]
    price = CalculatePrice.new.call(order:)

    assert_equal 300, price
  end
end
