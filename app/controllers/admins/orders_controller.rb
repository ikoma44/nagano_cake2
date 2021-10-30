class Admins::OrdersController < ApplicationController
  
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @total = 0
    @order_details.each do |order_detail|
      @mini_total = 0
      @price = order_detail.price
      @quantity = order_detail.quantity
      @mini_total = @price * @quantity
      @total += @mini_total
    end
  end
  
  def update
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    if @order.update(order_params)
      @order.order_details.update(production_status: "製作待ち") if @order.status == "入金確認"
      redirect_to request.referer
    else
      redirect_to request.referer
    end
  end
  
  def order_params
    params.require(:order).permit(:status)
  end
  
end
