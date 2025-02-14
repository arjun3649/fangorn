class VariantsController < ApplicationController
  def new
    @variant = Variant.new
  end
end
