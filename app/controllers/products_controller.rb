class ProductsController < ApplicationController
  before_action :set_product, only: [:edit, :update, :destroy] 
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)  # Changed to use product_params
    if @product.save
      flash[:notice] = "Product Added successfully!"
      redirect_to product_path
    else
      flash.now[:alert] = @product.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  rescue => e
    Rails.logger.error("Product creation error: #{e.message}")
    flash.now[:alert] = "An error occurred while creating the product"
    render :new, status: :unprocessable_entity
  end

  def edit
  end

  def update
    if @product.update(product_params)
      flash[:notice] = "Product updated successfully"  # Changed from flash.now to flash
      redirect_to products_path
    else
      flash.now[:alert] = @product.errors.full_messages.to_sentence
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    flash[:notice] = "Product was successfully deleted."
    respond_to do |format|
      format.html { redirect_to products_path, notice: "Product was successfully destroyed." }
      format.turbo_stream
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Product not found"
    redirect_to products_path
  end

  def product_params
    params.require(:product).permit(:primary_category, :price, :name, :description)
  end
end