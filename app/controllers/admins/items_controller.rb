class Admins::ItemsController < ApplicationController

  def index
    @items = Item.all
    @items = Item.all.page(params[:page]).per(10)
  end

  def new
  end

  def edit
  end

  def show
  end

  def update
  end

  def destroy
  end

end
