require 'rails_helper'

RSpec.describe "User Registrations", type: :request do
  describe "when user is authenticated" do
    let(:user) { create(:user) }
    let(:product) { create(:product, user: user) }

    before do
      sign_in user
    end

    describe "GET /index" do
      it "returns a success response" do
        get products_path
        expect(response).to be_successful
      end
    end

    describe "PATCH #update" do
      context "with valid params" do
        it "updates the requested product" do
          put product_path(product), params: { product: { name: "New Name" } }
          product.reload
          expect(product.name).to eq("New Name")
        end

        it "returns a success response" do
          put product_path(product), params: { product: { name: "New Name" } }
          expect(response).to have_http_status(:success)
        end
      end

      context "with invalid params" do
        it "does not update the product" do
          patch product_path(product), params: { product: { is_active: nil } }
          product.reload
          expect(product.name).to_not be_nil
        end

        it "returns an unprocessable_entity response" do
          patch product_path(0), params: { product: { is_active: nil } }
          expect(response).to have_http_status(:not_found)
        end
      end
    end

    describe "GET #show" do
      it "returns a success response" do
        get product_path(product)
        expect(response).to be_successful
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested product" do
        expect {
          delete product_path(product)
        }.to change(Product, :count).by(0)
      end

      it "returns a success response" do
        delete product_path(product)
        expect(response).to have_http_status(:no_content)
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new product" do
          expect {
            post products_path, params: { product: attributes_for(:product) }
          }.to change(Product, :count).by(1)
        end
  
        it "returns a created response" do
          post products_path, params: { product: attributes_for(:product) }
          expect(response).to have_http_status(:created)
        end
      end
    end
  end

  describe "when user is not authenticated" do
    let(:user) { create(:user) }
    let(:product) { create(:product, user: user) }

    describe "GET #index" do
      it "denies access" do
        get products_path
        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe "POST #create" do
      it "denies access" do
        post products_path, params: { product: attributes_for(:product) }
        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe "PATCH #update" do
      it "denies access" do
        patch product_path(product), params: { product: { name: "New Name" } }
        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe "DELETE #destroy" do
      it "denies access" do
        delete product_path(product)
        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe "GET #show" do
      it "denies access" do
        get product_path(product)
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
