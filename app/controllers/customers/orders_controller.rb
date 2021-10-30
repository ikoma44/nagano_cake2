class Customers::OrdersController < ApplicationController
  
  def new
    @order = Order.new
    @customer = current_customer
    @addresses = Address.where(customer_id: current_customer.id)
  end

  def confirm
    @order = Order.new(order_params)
    @customer = current_customer
    if params[:order][:address] == "0"
      @order.postal_code = @customer.postal_code
      @order.address = @customer.address
      @order.name = @customer.last_name + @customer.first_name
    elsif params[:order][:address] == "1"
      @address = Address.find(@sta)
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    elsif params[:order][:address] == "2"
      @order.postal_code = @order.postal_code
      @order.address = @order.address
      @order.name = @order.name
    end
    @cart_items = current_customer.cart_items
    #↓ちがうかもorder_detailにデータが入るようにしてるのか？
    #@price = @order_detail.amount * @order_detail.price
    @shipping_cost = 800
    #@priceはorder_detailsのやつ。違うかも@order.order_details.price
    #@total_payment = @order.order_details.price + @shipping_cost
  end

  def create
    @order = Order.new(order_params)
    @order.save
    current_customer.cart_items.each do |cart_item|
      @order_detail = @order.order_details.build
      @order_detail.order_id = @order.id
      @order_detail.item_id = cart_item.item_id
      @order_detail.amount = cart_item.amount
      #@order_detail.price = cart_item.amount * price
      @order_detail.save
    end
    current_customer.cart_items.destroy_all
    redirect_to orders_complete_path
  end

  def complete
  end

  def index
  end

  def show
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :pshipping_cost, :total_payment, :payment_method, :status)
  end
  
end
