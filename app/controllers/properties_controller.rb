class PropertiesController < ApplicationController
  before_action :set_product
  before_action :set_property, only: [ :edit, :update ]

  def index
  end


def search
  Rails.logger.info "Searching for: #{params[:query]}"
   Rails.logger.info "Found #{@properties.size} properties"
  @product = Product.find(params[:product_id])      
  @properties = @product.properties
                  .where('name LIKE ?', "%#{params[:query]}%")
                  .limit(10)  # Add limit for safety
                  

  render json: @properties.as_json(only: [:id, :name, :description, :unit])
end

  def new
    @property = Property.new
  end

  def create
    @property = Property.new(property_params)
    @property.product_id = params[:product_id]
    if @property.save
      flash[:notice] = "Property Added successfully!"
      redirect_to product_path(params[:product_id])
    else
      flash.now[:alert] = @property.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  rescue => e
    Rails.logger.error("Property creation error: #{e.message}")
    flash.now[:alert] = "An error occurred while creating the property"
    render :new, status: :unprocessable_entity
  end

  def edit
  end

  def update
    if @property.update(property_params)
      @property.update(updated_at: Time.current)
      flash[:notice] = "Property updated successfully"
      redirect_to product_path(@product)
    else
      flash.now[:alert] = @property.errors.full_messages.to_sentence
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @property.update(deleted_at: Time.current)
    flash[:notice] = "Property was successfully deleted."
    redirect_to product_path(@product)
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Product not found"
    redirect_to products_path
  end

  def set_property
    @property = @product.property.find(params[:id])
  end

  def property_params
    params.require(:property).permit(:unit, :name, :description)
  end
end