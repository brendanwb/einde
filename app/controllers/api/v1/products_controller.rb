class Api::V1::ProductsController < ApiController
  def create
    authorize do |user|
      @product = Product.new(product_params)

      if @product.save
        render
      else
        render json: {
          message: 'Validation Failed',
          errors: @product.errors.full_messages
        }, status: 422
      end
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  private

  def product_params
    {
      brand: params[:brand],
      name: params[:name],
      upc: params[:upc],
      description: params[:description],
      units: params[:units],
      measurement: params[:measurement],
      category: params[:category]
    }
  end
end
