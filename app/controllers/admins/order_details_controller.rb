class Admins::OrderDetailsController < ApplicationController
    
  def update
    @order_detail = OrderDetail.find(params[:id])
    @order_detail.update(order_detail_params)
    @order = @order_detail.order
    if @order_detail.making_status == "製作中"
      @order.update(status: "製作中")
      redirect_to admins_order_path(@order)
    elsif @order_detail.making_status == "製作完了"
      @order.update(status: "発送待ち")
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
