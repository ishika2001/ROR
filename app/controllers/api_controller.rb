# frozen_string_literal: true

# app/controllers/api_controller.rb
class ApiController < ApplicationController
  protect_from_forgery with: :null_session

  def current_user
    token = request.headers['Authorization']&.split(' ')&.last
    return unless token
    decoded = AuthenticationTokenService.decode_token(token)
    @current_user = User.find(decoded['user_id'])
    # rescue ActiveRecord::RecordNotFound, JWT::DecodeError
    # nil
  end

  def authenticate_request
    render json: { error: 'Not Authorized' }, status: :unauthorized unless current_user
  end
end
