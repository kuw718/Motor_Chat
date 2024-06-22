class CustomersController < ApplicationController
  before_action :disable_foreign_keys, only: [:destroy]

  def edit
    @customer = Customer.find(params[:id])
  end

  def show
    @customer = Customer.find(params[:id])
    @following_customers = @customer.following_customers
    @follower_customers = @customer.follower_customers
    @post_images = @customer.post_images.page(params[:page]).per(10)
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to customer_path(@customer.id)
  end

  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy
    redirect_to root_path, notice: "アカウントが削除されました。"
  end

  def follows
    customer = Customer.find(params[:id])
    @customers = customer.following_customers
  end

  def followers
    customer = Customer.find(params[:id])
    @customer = customer.follower_customers
  end

  def liked_posts
    @liked_posts = current_customer.liked_posts
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :profile_image)
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