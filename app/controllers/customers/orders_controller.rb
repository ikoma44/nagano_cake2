class Customers::OrdersController < ApplicationController
  
  def new
    @order = Order.new
    @customer = current_customer
    @addresses = Address.where(customer_id: current_customer.id)
  end

  def confirm
    @order = Order.new(order_params)
    if params[:order][:order_address] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:order_address] == "1"
      @address = Address.find(params[:id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    elsif params[:order][:order_address] == "2"
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
      @order_detail.price = cart_item.item.price
      @order_detail.save
    end
    current_customer.cart_items.destroy_all
    redirect_to orders_complete_path
  end

  def complete
  end

  def index
    @orders = Order.where(customer_id: current_customer.id)
    @shipping_cost = 800
    #@total_payment = @total + @shipping_cost
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @shipping_cost = 800
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
  end
  
end
