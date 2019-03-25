require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it "saves new products with name, price, quantity and category filled out" do
      @category = Category.create!(name: "Awesome things")

      @product = Product.new(name: "new thing", price: 200, quantity: 4, category: @category)

      expect(@product.save!).to eq true
    end

    it "fails to save a new product without name" do
      @category = Category.create!(name: "Awesome things")
      
      @product = Product.create(name: nil, price: 200, quantity: 4, category: @category)

      expect(@product.errors.full_messages_for(:name)).to  include "Name can't be blank"
    end

    it "fails to save a new product without price" do
      @category = Category.create!(name: "Awesome things")
        
      @product = Product.create(name: "Thing", price: nil, quantity: 4, category: @category)

      expect(@product.errors.full_messages_for(:price)).to  include "Price can't be blank"
    end

    it "fails to save a new product without quantity" do
      @category = Category.create!(name: "Awesome things")
        
      @product = Product.create(name: "Thing", price: 500, quantity: nil, category: @category)

      expect(@product.errors.full_messages_for(:quantity)).to  include "Quantity can't be blank"
    end
    
    it "fails to save a new product without category" do     
      @product = Product.create(name: "Thing", price: 500, quantity: nil, category: nil)

      expect(@product.errors.full_messages_for(:category)).to  include "Category can't be blank"
    end
  end
end
