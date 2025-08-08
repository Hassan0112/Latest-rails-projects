class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.admin?
      @orders = OrderQuery.new(order.all).call(params)
    else
      @orders = current_user.orders.recent
    end
  end

  def show
    @order = current_user.admin? ? Order.find(params[:id]) : current_user.orders.find(params[:id])
  end

  def create
    order = CreateOrderService.new(current_user).call
    redirect_to order_path(order), notice: "Order placed!"
  end

  private

  def cart_total(cart)
    cart.cart_items.includes(:product).sum { |item| item.quantity * item.product.price }
  end
end