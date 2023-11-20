# frozen_string_literal: true

# app/controllers/users_controller.rb
class UsersController < ApplicationController
  def index
    @user = User.all.where(role: 0)
    @q = @user.ransack(params[:q])
    @users = @q.result(distinct: true)
  end
end
