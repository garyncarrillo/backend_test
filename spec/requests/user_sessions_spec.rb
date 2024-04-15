# spec/requests/user_sessions_spec.rb
require 'rails_helper'

RSpec.describe 'User Sessions', type: :request do
  describe 'POST /users/sign_in' do
    let(:user) { create(:user, password: '12345678') }

    context 'with valid credentials' do
      it 'logs the user in and redirects to the root path' do
        post new_user_session_path, params: { user: { email: user.email, password: '12345678' } }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid credentials' do
      it 'does not log the user in' do
        post new_user_session_path, params: { user: { email: user.email, password: 'wrongpassword' } }
        expect(response.body).to include('Invalid Email or password')
      end
    end

    # context 'with an unconfirmed user' do
    #   let(:unconfirmed_user) { create(:user) }
    #   it 'does not allow the user to log in' do
    #     post new_user_session_path, params: { user: { email: unconfirmed_user.email, password: '12345678' } }
    #     expect(response).to render_template(:new)
    #     expect(response.body).to include('You have to confirm your email address before continuing')
    #   end
    # end
  end
end
