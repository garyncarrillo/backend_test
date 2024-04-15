class ApplicationController < ActionController::API
  before_action :authenticate_user!  
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  private

  def render_not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end
end
