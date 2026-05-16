class OrdersController < ApplicationController
  def index
    @orders = Order.open.with_pizzas
  end

  def update
  end
end
