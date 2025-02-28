class ProductPropertiesController < ApplicationController
  before_action :set_product
  
  def new
    @matching_properties = Property.where("name LIKE ?", "%#{params[:search]}%") if params[:search].present?
  end
  
  def create
    if params[:property_id].present?
      # Using an existing property
      @property = Property.find(params[:property_id])
    else
      # Creating a new property that belongs to this product
      @property = Property.new(
        name: params[:property_name],
        unit: params[:property_unit],
        description: params[:property_description]
      )
      
      unless @property.save
        @matching_properties = Property.where("name LIKE ?", "%#{params[:search]}%") if params[:search].present?
        @errors = @property.errors.full_messages
        return render :new
      end
    end
    
    # Create the association between product and property
    product_property = @product.product_properties.new(
      property: @property,
      value: params[:value],
      remarks: params[:remarks]
    )
    
    if product_property.save
      redirect_to @product, notice: "Property added successfully"
    else
      @matching_properties = Property.where("name LIKE ?", "%#{params[:search]}%") if params[:search].present?
      @errors = product_property.errors.full_messages
      render :new
    end
  end
  
  private
  
  def set_product
    @product = Product.find(params[:product_id])
  end
end