require 'rails_helper'

RSpec.describe "User Registrations", type: :request do
  describe "POST /users" do
    let(:user_params) do
      {
        user: {
          email: Faker::Internet.email,
          password: 'password123',
          password_confirmation: 'password123'
        }
      }
    end

    it "creates a new user" do
      expect do
        post user_registration_path, params: user_params
      end
      expect(response).to have_http_status(201) # O ajusta según la respuesta esperada
    end

    it "does not create user with invalid parameters" do
      # Cambiar a parámetros inválidos
      invalid_user_params = user_params.deep_merge(user: { email: '', password: '123', password_confirmation: '321' })
      
      expect do
        post user_registration_path, params: invalid_user_params
      end.not_to change(User, :count)

      expect(response).to have_http_status(:unprocessable_entity)  # 422 Unprocessable Entity
    end
  end
end
