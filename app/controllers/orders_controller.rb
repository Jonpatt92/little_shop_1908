class OrdersController < ApplicationController

  def new
    @cart = cart
  end

  def show
    # binding.pry
    @order = Order.find(params[:order_id])
  end

  def create
    new_order = Order.new(order_params)
    if new_order.save
      cart.contents.each do |item_id, quantity|
        item = Item.find(item_id)
        OrderItem.create(order_id: "#{new_order.id}", item_id: item_id, price: "#{item.price}", quantity: quantity)
      end
    redirect_to "/orders/#{new_order.id}"
    else
      flash.now[:notice] = "Please fill in all forms before submitting order"
      render :new
    end
  end

  private

  def order_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end
