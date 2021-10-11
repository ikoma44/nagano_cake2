class Admins::CustomersController < ApplicationController

  def index
    @customer = Customer.all
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
