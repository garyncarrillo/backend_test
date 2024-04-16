class ProductsController < ApplicationController
  before_action :set_product_service

  def create
    product = @product_service.create(product_params)
    
    if product
      render json: product, serializer: ProductSerializer, status: :created
    else
      render json: { errors: product.errors.messages }, status: :unprocessable_entity
    end
  end

  def update
    product = @product_service.update_product(product_params)
    
    if product
      render json: product, serializer: ProductSerializer, status: 201
    else
      render json: { errors: product.errors.messages}, status: :unprocessable_entity
    end
  end

  def destroy
    begin
      @product_service.destroy()
      head :no_content
    rescue => e
      render json: { errors: {base: I18n.t(:cant_be_deleted)} }, status: :unprocessable_entity
    end
  end

  def index
    products = @product_service.fetch_all()
    render json: products, each_serializer: ProductSerializer, status: 201
  end

  def show
    product = @product_service.fetch_one()
    render json: product, serializer: ProductSerializer, status: 201
  end

  private

  def set_product_service
    @product_service = ProductService.new(current_user, params)
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :is_active)
  end
end
