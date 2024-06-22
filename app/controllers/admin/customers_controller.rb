class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_customer, only: [:edit, :update, :destroy, :unsubscribe]
  before_action :disable_foreign_keys, only: [:destroy]

  def show
  end

  def edit
  end

  def update
    retry_count = 0
    begin
      ActiveRecord::Base.transaction do
        if @customer.update(customer_params)
          redirect_to admin_path, notice: "Customer was successfully updated."
        else
          render :edit
        end
      end
    rescue ActiveRecord::StatementInvalid => e
      if e.message.include?("database is locked") && retry_count < 5
        retry_count += 1
        sleep(0.1)
        retry
      else
        raise e
      end
    end
  end

  def destroy
    @customer.destroy
    redirect_to admin_path, notice: "Customer was successfully destroyed."
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:name, :email, :profile_image)
  end
  
  def disable_foreign_keys
    if ActiveRecord::Base.connection.adapter_name.downcase.include?("mysql")
      ActiveRecord::Base.connection.execute("SET foreign_key_checks = 0")
    elsif ActiveRecord::Base.connection.adapter_name.downcase.include?("sqlite")
      ActiveRecord::Base.connection.execute("PRAGMA foreign_keys = OFF")
    else
      raise "Unsupported database adapter"
    end
  end
end