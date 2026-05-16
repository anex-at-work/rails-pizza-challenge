require "test_helper"

class CalculatePriceTest < ActiveSupport::TestCase
  test "should summ all prizes regarding multipliers for simple order without discount and promotions" do
    order = FactoryBot.create(:order, order_pizzas_count: 0, with_discount: false, with_promotions: false)
    pizza = FactoryBot.create(:pizza, price: 100)
    FactoryBot.create(:order_pizza, order: order, size_multiplier: 1.0, pizza:, add: nil)
    FactoryBot.create(:order_pizza, order: order, size_multiplier: 1.5, pizza:, add: [])
    order.reload
    price = CalculatePrice.new.call(order:)

    assert_equal 250, price
  end

  test "should not affect price for order with removed ingredients" do
    order = FactoryBot.create(:order, order_pizzas_count: 0, with_discount: false, with_promotions: false)
    pizza = FactoryBot.create(:pizza, price: 100)
    FactoryBot.create(:order_pizza, order: order, size_multiplier: 1.0, pizza:, add: [], remove: [ { name: "Onions", price: 100 } ])
    order.reload
    price = CalculatePrice.new.call(order:)

    assert_equal 100, price
  end

  test "should add ingredients prices regarding multiplier for order with add ingredients" do
    order = FactoryBot.create(:order, order_pizzas_count: 0, with_discount: false, with_promotions: false)
    pizza = FactoryBot.create(:pizza, price: 100)
    FactoryBot.create(:order_pizza, order: order, size_multiplier: 1.5, pizza:, add: [ { name: "Onions", price: 100 } ])
    order.reload
    price = CalculatePrice.new.call(order:)

    assert_equal 300, price
  end

  test "should correctly apply promotions" do
    order = FactoryBot.create(:order, order_pizzas_count: 0, promotions: [ "2FOR1" ], with_discount: false)
    pizza = FactoryBot.create(:pizza, :salami, price: 100)
    FactoryBot.create_list(:order_pizza, 4, order: order, pizza:, size: "small", size_multiplier: 1.0, add: [])
    order.reload
    price = CalculatePrice.new.call(order:)

    assert_equal 200, price
  end

  test "should correctly apply discount promotions" do
    order = FactoryBot.create(:order, order_pizzas_count: 0, discount: "SAVE5", with_promotions: false)
    pizza = FactoryBot.create(:pizza, :salami, price: 100)
    FactoryBot.create_list(:order_pizza, 2, order: order, pizza:, size: "small", size_multiplier: 1.0, add: [])
    order.reload
    price = CalculatePrice.new.call(order:)

    assert_equal 190, price
  end
end
