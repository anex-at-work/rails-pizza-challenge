require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest
  test "should have a route for orders index" do
    assert_routing({ method: "get", path: "/orders" }, { controller: "orders", action: "index" })
  end

  test "should have a route for order update" do
    assert_routing({ method: "patch", path: "/orders/any-id" }, { controller: "orders", action: "update", id: "any-id" })
  end

  test "should get index" do
    get orders_url
    assert_response :success
  end

  test "should patch update" do
    order = FactoryBot.create(:order)
    patch order_url(order)
    assert_response :success
  end
end
