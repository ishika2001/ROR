# frozen_string_literal: true

# app/controllers/organizers_controller.rb
class OrganizersController < ApplicationController
  def index
    @users = User.all.where(role: 0)
  end

  def show
    @user = User.find(params[:id])
  end
end
