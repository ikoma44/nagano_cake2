class Admins::CustomersController < ApplicationController

  def index
    @customers = Customer.all
    @customers = Customer.page(params[:page])
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer.update(customer_params)
    redirect_to admins_customer_path(@customer.id)
  end

end
