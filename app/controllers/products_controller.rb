class ProductsController < ApplicationController

  def index
    @products = Product.all.order(created_at: :desc)
  end

  def show
    @product = Product.find params[:id]
    @reviews = @product.reviews
    puts "-------------------reviewssss"
    puts "for this product", @product.inspect
    puts "with this id", @product.id
    puts "this is reviews", @reviews.inspect
  end

end
