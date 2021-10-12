class Admins::ItemsController < ApplicationController

  def index
    @items = Item.all
    @items = Item.all.page(params[:page]).per(10)
  end

  def new
    @item = Item.new
  end

  def edit
    @item = Item.find(params[:id])
  end

  def show
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    @item.save
    redirect_to admins_item_path(@item.id)
  end

  def create
    @item = Item.new(item_params)
    @item.save
    redirect_to admins_item_path(@item.id)
  end

  private
  def item_params
    params.require(:item).permit(:genre_id, :name, :image_id, :introduction, :price, :is_active)
  end

end
