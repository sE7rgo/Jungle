require 'rails_helper'


RSpec.describe Product, type: :model do
  describe 'Validations' do

    it "indeed save successfully with all arguments" do
      @category = Category.create(name: "Estate")
      @product = Product.create(name: "House", price: 50, quantity: 2, category: @category)

      @product.valid?
      expect(@product.errors.full_messages).to eq([])
    end

    it "should have a name" do
      @category = Category.create(name: "Estate")
      @product = Product.create(name: nil)
    
      @product.valid?
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it "should have a price" do
      @category = Category.create(name: "Estate")
      @product = Product.create(name: "House", price: nil)

      @product.valid?
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it "should have a quantity" do
      @category = Category.create(name: "Estate")
      @product = Product.create(name: "House", price: 50, quantity: nil)

      @product.valid?
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it "validates :category" do
      @category = Category.create(name: "Estate")
      @product = Product.create(name: "House", price: 50, quantity: 2)

      @product.valid?
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end