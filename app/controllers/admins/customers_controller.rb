class Admins::CustomersController < ApplicationController

  def index
    @customers = Customer.page(params[:page])
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to admins_customer_path(@customer)

  end

  private

  def customer_params
   params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :telephone_number, :postal_code, :email, :address, :is_active)
  end
end
