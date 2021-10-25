class Customers::CustomersController < ApplicationController
  
  def show
    @customer = current_customer
  end
  
  def edit
    @customer = current_customer
  end      
  
  def update
    customer = current_customer
    customer.update(customer_params)
    redirect_to customer_path(current_customer)
    
  end      
  
  def confirm
  end
  
  def withdraw
    @customer = current_customer
    @customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
    redirect_to root_path
  end
  
private

  def customer_params
   params.require(:member).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :telephone_number, :postal_code, :email, :address, :is_active)
  end
  
end
