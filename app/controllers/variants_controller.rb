class VariantsController < ApplicationController
  before_action :set_product
  def new
    @variant = Variant.new
  end
def create
  @variant = Variant.new(variant_params)
  @variant.product_id = params[:product_id]
  @variant.created_by = Current.user.email_address if Current.user

  if @variant.save
    flash[:notice] = "Variant was successfully created"
    redirect_to product_path(params[:product_id])  # This will redirect back to the product show page
  else
    flash.now[:alert] = @variant.errors.full_messages.to_sentence
    render :new, status: :unprocessable_entity
  end
end

  private

  def variant_params
    params.require(:variant).permit(:name, :variation_criteria)
  end

   def set_product
    @product = Product.find(params[:product_id])
   end
end
