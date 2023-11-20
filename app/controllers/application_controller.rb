# frozen_string_literal: true

# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :name, :password, :password_confirmation, :role) }
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
