# frozen_string_literal: true

# app/controllers/home_controller.rb
class HomeController < ApplicationController
  def index
      @q = Event.ransack(params[:q])
      @events = @q.result(distinct: true)

    # @events = Event.all
    if user_signed_in?
      if current_user.role == 'attender'
        render '/users/attender_dashboard'
      else
        render '/users/organizer_dashboard'
      end
    end
  end
end
