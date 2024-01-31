class Api::V1::ProductsController < ApplicationController
  before_action :authenticate
 
  def index
    @products = Product.all
    
    render json: {
      products: @products,
      current_user: {
        id: @current_user.id,
        username: @current_user.username,
      }
    }
  end

  def create 
    product = Product.new(product_params)
    product.user_id = @current_user.id
    if product.save
      render json: {status: "SUCCESS", message: "Product was created successfully!", data: product}, status: :created
    else
      render json: product.errors, status: :unprocessable_entity
    end
  end

  private

  def product_params
    params.permit(:name, :description)
  end
end