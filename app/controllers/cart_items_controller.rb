class CartItemsController < ApplicationController

    def create
        cart = current_user.cart || current_user.create.cart
        cartitem = cart.cartitem_find_or_intialize_by(product_id: params[:product_id])
        item.quanity += 1
        item.save!
        redirect_to cart_path
    end
end