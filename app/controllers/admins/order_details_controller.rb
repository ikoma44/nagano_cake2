class Admins::OrderDetailsController < ApplicationController
    
  def update
      @order = Order.find(params[:order_id])
      @order_detail = OrderDetail.find(params[:id])
      @order_details = @order_detail.order.order_details
      @order_detail.update(order_detail_params)
    if @order_detail.production_status == "製作中"
      @order.update(status: "製作中")
      redirect_to admins_order_path(@order)
    elsif @order_details.where(production_status: "製作完了").count == @order_details.count
      @order.update(status: "発送準備中")
      redirect_to admins_order_path(@order)
    else
      redirect_to admins_order_path(@order)
    end
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:order_id, :item_id, :price, :amount, :making_status)
  end
    
end
