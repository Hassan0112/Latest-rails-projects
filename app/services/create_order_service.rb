class CreateOrderService

    def initalize(user)
        @user = user
        @cart = user.cart
    end

    def call
        Activerecord::Base.transaction do
        order = current_user.orders.create!(total: cart_total(cart), status: "pending")

        cart.cart_items.each do |item|
            order.order_items.create!(
                product: item.product,
                quantity: item.quantity,
                price: item.product.price
            )
        end

        cart.cart_items.destroy_all
        redirect_to order_path(order), notice: "Order placed!"
    end
    
      private

    def cart_total(cart)
        cart.cart_items.includes(:product).sum { |item| item.quantity * item.product.price }
    end
end