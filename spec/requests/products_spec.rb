require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe "when user is authenticated" do
    let(:user) { create(:user) }
    let(:product) { create(:product) }

    before do
      sign_in user
    end

    describe "GET #index" do
      it "returns a success response" do
        get :index
        expect(response).to be_successful
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new product" do
          expect {
            post :create, params: { product: attributes_for(:product) }
          }.to change(Product, :count).by(1)
        end

        it "returns a created response" do
          post :create, params: { product: attributes_for(:product) }
          expect(response).to have_http_status(:created)
        end
      end
    end

    describe "PATCH #update" do
      context "with valid params" do
        it "updates the requested product" do
          patch :update, params: { id: product.to_param, product: { name: "New Name" } }
          product.reload
          expect(product.name).to eq("New Name")
        end

        it "returns a success response" do
          patch :update, params: { id: product.id, product: { name: "New Name" } }
          expect(response).to have_http_status(:success)
        end
      end

      context "with invalid params" do
        it "does not update the product" do
          patch :update, params: { id: product.id, product: { is_active: nil } }
          product.reload
          expect(product.name).to_not be_nil
        end

        it "returns an unprocessable_entity response" do
          patch :update, params: { id: 0, product: { is_active: nil } }
          expect(response).to have_http_status(:not_found)
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested product" do
        product = create(:product)
        expect {
          delete :destroy, params: { id: product.id }
        }.to change(Product, :count).by(-1)
      end

      it "returns a success response" do
        delete :destroy, params: { id: product.id }
        expect(response).to have_http_status(:no_content)
      end
    end

    describe "GET #show" do
      it "returns a success response" do
        product = create(:product)
        get :show, params: { id: product.to_param }
        expect(response).to be_successful
      end
    end
  end

  describe "when user is not authenticated" do
    let(:product) { create(:product) }

    describe "GET #index" do
      it "denies access" do
        get :index
        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe "POST #create" do
      it "denies access" do
        post :create, params: { product: attributes_for(:product) }
        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe "PATCH #update" do
      it "denies access" do
        patch :update, params: { id: product.to_param, product: { name: "New Name" } }
        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe "DELETE #destroy" do
      it "denies access" do
        delete :destroy, params: { id: product.id }
        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe "GET #show" do
      it "denies access" do
        get :show, params: { id: product.to_param }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
