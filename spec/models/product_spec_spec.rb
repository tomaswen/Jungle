require 'rails_helper'

RSpec.describe Product, type: :model do

  describe 'Validations' do

    it "is valid with valid attributes" do
      category = Category.create(name: 'Apparel')
      product = Product.create(name: 'Shoes', category: category, quantity: 2, price: 120)
      expect(product).to be_valid
    end

    it "is not valid without a name" do
      category = Category.create(name: 'Apparel')
      product = Product.create(name: nil, category: category, quantity: 2, price: 120)
      expect(product).to_not be_valid
      expect(product.errors.full_messages[0]).to eq "Name can't be blank"
    end

    it "is not valid without a price" do
      category = Category.create(name: 'Apparel')
      product = Product.create(name: 'backpack', category: category, quantity: 2, price: nil)
      expect(product).to_not be_valid
      expect(product.errors.full_messages[0]).to eq "Price cents is not a number"
    end

    it "is not valid without a quantity" do
      category = Category.create(name: 'Apparel')
      product = Product.create(name: 'backpack', category: category, quantity: nil, price: 120)
      expect(product).to_not be_valid
      expect(product.errors.full_messages[0]).to eq "Quantity can't be blank"
    end

    it "is not valid without a category" do
      product = Product.create(name: 'backpack', category: nil, quantity: 1, price: 120)
      expect(product).to_not be_valid
      expect(product.errors.full_messages[0]).to eq "Category can't be blank"
    end
  end
end