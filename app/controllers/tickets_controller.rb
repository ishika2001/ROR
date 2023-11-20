# frozen_string_literal: true

# app/controllers/tickets_controller.rb
class TicketsController < ApplicationController
 
  def show
    @event = Event.find(params[:event_id])
    @ticket = @event.tickets
    @booked = 0
    @unbooked = 0
    @ticket.each do |t|
      if t.status == 'not-booked'
        @unbooked += 1
      else
        @booked += 1
      end
    end
  end

  def new 
    @ticket = Ticket.new 
  end

  def create
    @user = current_user
    if @user.role == 'organizer'
      @ticket = @user.tickets.create(ticket_params)
      redirect_to @ticket
    else
      flash[:error] = 'You must have the organizer role to create tickets.'
      redirect_to root_path
    end
  end

  def book
    @user = current_user
    @ticket = Ticket.find_by(id: params[:id])
    if @ticket
        if @ticket.status == 'not-booked'
          @user.tickets << @ticket
          @ticket.status = 'booked'
          if @ticket.save
            flash[:success] = 'Ticket booked count updated.'
          else
            flash[:error] = 'Failed to update Ticket booked count.'
          end
        end
    else
      flash[:error] = 'Ticket record not found.'
    end
  end

  def download_pdf
    ticket_id = params[:id]
    @ticket_to_be_download = Ticket.find_by(id: ticket_id)
    send_data generate_pdf(@ticket_to_be_download),
    filename: 'ticket.pdf',
    type: 'application/pdf'
  end

  private

  def generate_pdf(ticket)
    if ticket
      Prawn::Document.new do
        text 'Congratulations You got the ticket!', align: :center
        text "Event-Name: #{ticket.event.title}"
        text "Ticket-Name: #{ticket.name}"
        text "Price: #{ticket.price}"
      end.render
    end
  end

  def ticket_params
    params.require(:ticket).permit(:name, :price)
  end
end
