require "test_helper"

class ApplyPromotionsTest < ActiveSupport::TestCase
  test "should raise an error for unknown promotion" do
    order = FactoryBot.create(:order, promotions: [ "UNKNOWN" ])
    assert_raises(ArgumentError) do
      ApplyPromotions.new.call(order:)
    end
  end

  test "should modify order with valid promotion 2FOR1" do
    order = FactoryBot.create(:order, promotions: [ "2FOR1" ], order_pizzas_count: 0)
    pizza = FactoryBot.create(:pizza, :salami)
    FactoryBot.create_list(:order_pizza, 2, order: order, pizza:, size: "small")
    order.reload

    order_clone = ApplyPromotions.new.call(order:)
    assert_equal 1, order_clone.order_pizzas.size
  end

  test "should modify order with multiple valid promotion 2FOR1" do
    order = FactoryBot.create(:order, promotions: [ "2FOR1" ] * 2, order_pizzas_count: 0)
    pizza = FactoryBot.create(:pizza, :salami)
    FactoryBot.create_list(:order_pizza, 4, order: order, pizza:, size: "small")
    order.reload

    order_clone = ApplyPromotions.new.call(order:)
    assert_equal 1, order_clone.order_pizzas.size
  end

  test "should correctly work with different definition of promotion NForK" do
    promotion = Promotions::NForK.new(policy: {
      target: "Salami",
      target_size: "small",
      from: 3,
      to: 2
    })
    order = FactoryBot.create(:order, promotions: [ "3FOR2" ], order_pizzas_count: 0)
    pizza = FactoryBot.create(:pizza, :salami)
    FactoryBot.create_list(:order_pizza, 4, order: order, pizza:, size: "small")
    order.reload

    apply_promotions = ApplyPromotions.new(promotions: { "3FOR2" => promotion })
    order_clone = apply_promotions.call(order:)
    assert_equal 2, order_clone.order_pizzas.size
  end

  test "should apply promotion only for target pizzas" do
    order = FactoryBot.create(:order, promotions: [ "2FOR1" ], order_pizzas_count: 0)
    salami = FactoryBot.create(:pizza, :salami)
    tonno = FactoryBot.create(:pizza, :tonno)
    FactoryBot.create_list(:order_pizza, 2, order: order, pizza: salami, size: "small")
    FactoryBot.create_list(:order_pizza, 2, order: order, pizza: tonno, size: "small")
    order.reload

    order_clone = ApplyPromotions.new.call(order:)
    assert_equal 3, order_clone.order_pizzas.size
  end
end
