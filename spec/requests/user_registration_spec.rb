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
      end.to change(User, :count).by(1)
    
      expect(response).to have_http_status(200)
    end
  end
end
