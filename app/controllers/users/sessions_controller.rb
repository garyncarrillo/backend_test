# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def create
    super do |resource|
      jwt_token = request.env['warden-jwt_auth.token']
      render json: { jwt: jwt_token, message: "Logged in successfully.", user: resource }, status: :ok and return
    end
  end

  private

  def respond_to_on_destroy
    head :no_content
  end
end
