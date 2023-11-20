# frozen_string_literal: true

# app/controllers/events_controller.rb
class EventsController < ApplicationController
  def show
    @events = Event.all
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @user = current_user
    @event = @user.events.create(event_params)
    CrudNotificatonMailer.create_notification(@event).deliver_later
    redirect_to @event
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to @event
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to root_path, status: :see_other
  end

  private

  def event_params
    params.require(:event).permit(:title, :date, :time, :venue, :description, :image)
  end
end
