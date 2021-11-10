class Admins::OrdersController < ApplicationController
  
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @shipping_cost = 800
  end
  
  def update
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    if @order.update(order_params)
      @order.order_details.update(making_status: "製作待ち") if @order.status == "入金確認"
      redirect_to request.referer
    else
      redirect_to request.referer
    end
  end
  
  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
  end
  
end
