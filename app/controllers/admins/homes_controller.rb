class Admins::HomesController < ApplicationController
  
  def top
    @orders = Order.all
    @orders = Order.page(params[:page]).order(created_at: :desc).per(10)
  end
  
end
