class Customers::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page]).order(created_at: :desc).per(8)
    @items = Item.all
    @genres = Genre.all
  end

  def show
    @customer = current_customer
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @genre = Genre.find(@item.genre_id)
    @genres = Genre.all
  end
end
