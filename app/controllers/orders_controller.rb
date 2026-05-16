class OrdersController < ApplicationController
  def index
    @orders = Order.open.with_pizzas
  end

  def update
    order = Order.find(params[:id])
    order.completed!

    redirect_to orders_url, notice: "Order completed."
  end
end
