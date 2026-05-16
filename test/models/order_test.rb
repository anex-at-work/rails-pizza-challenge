require "test_helper"

class OrderTest < ActiveSupport::TestCase
  test "should create ID in UUID format" do
    order = FactoryBot.create(:order)
    assert_equal 36, order.id.length
  end
end
