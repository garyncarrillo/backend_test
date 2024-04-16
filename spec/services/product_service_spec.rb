require 'rails_helper'

RSpec.describe ProductService do
  let(:user) { create(:user) }
  let(:product) { create(:product, user_id: user.id) }
  let(:params) { { id: product.id } }
  let(:product_params) { { name: "New Product", description: "Description", price: 10 } }
  let(:product_service) { ProductService.new(user, params) }

  describe "#create" do
    it "creates a new product" do
      expect { product_service.create(product_params) }.to change(Product, :count).by(2)
    end
  end

  describe "#update_product" do
    let!(:product) { create(:product, user: user) }

    it "updates the product" do
      product_service.update_product(product_params)
      expect(product.reload.name).to eq("New Product")
    end
  end

  describe "#destroy" do
    let!(:product) { create(:product, user: user) }

    it "destroys the product" do
      expect { product_service.destroy }.to change(Product, :count).by(-1)
    end
  end

  describe "#fetch_all" do
    it "returns all products belonging to the user" do
      expect(product_service.fetch_all()).to match_array(product)
    end
  end

  describe "#fetch_one" do
    let!(:product) { create(:product, user: user) }

    it "returns the product with the given id belonging to the user" do
      expect(product_service.fetch_one).to eq(product)
    end
  end
end
