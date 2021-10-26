class Admins::ItemsController < ApplicationController

  def index
    @items = Item.page(params[:page])
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admins_item_path(@item.id)
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
    @genre = Genre.find(@item.genre_id)
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admins_item_path(@item)
    else
      render :edit
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  private
  def item_params
    params.require(:item).permit(:genre_id, :name, :price,
    :introduction, :image, :is_active)
  end

end
