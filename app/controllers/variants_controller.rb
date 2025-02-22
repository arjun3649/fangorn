class VariantsController < ApplicationController
  before_action :set_product
  before_action :set_variant, only: [ :edit, :update, :destroy ]

  def new
    @variant = Variant.new
  end

  def create
    @variant = Variant.new(variant_params)
    @variant.product_id = params[:product_id]
    @variant.created_by = params[:created_by]

    if @variant.save
      flash[:notice] = "Variant was successfully created"
      redirect_to product_path(@product)
    else
      flash.now[:alert] = @variant.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @variant.update(variant_params)
      flash[:notice] = "Variant updated successfully"
      redirect_to product_path(@product)
    else
      flash.now[:alert] = @variant.errors.full_messages.to_sentence
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @variant.update(deleted_at: Time.current)
    flash[:notice] = "Variant was successfully deleted."
    redirect_to product_path(@product)
  end

  private

  def variant_params
    params.require(:variant).permit(:name, :variation_criteria)
  end

  def set_variant
    @variant = @product.variant.find(params[:id])  # Changed from variant to variants
  end



  def set_product
    @product = Product.find(params[:product_id])
  end
end