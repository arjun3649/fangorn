class ProductsController < ApplicationController
  def index
  @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product= Product.new(primary_category: params[:primary_category], price: params[:price], name: params[:name], description: params[:description])
    if @product.save
      flash.now[:alert]= "Product Added successful!"
      redirect_to "/"
    else
      flash.now[:alert] = @user.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  rescue => e
    Rails.logger.error("Signup error: #{e.message}")
    flash.now[:alert] = "An error occurred during signup"
    render :new, status: :unprocessable_entity
  end
end
