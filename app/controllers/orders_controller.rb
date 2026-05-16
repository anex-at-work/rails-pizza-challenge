class OrdersController < ApplicationController
  include ActionView::RecordIdentifier

  def index
    @orders = Order.open.with_pizzas
  end

  def update
    order = Order.find(params[:id])
    order.completed!

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(dom_id(order)) }
      format.html { redirect_to orders_url, notice: "Order completed." }
    end
  end
end
