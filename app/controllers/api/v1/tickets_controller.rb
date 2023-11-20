class Api::V1::TicketsController < ApiController
  protect_from_forgery with: :null_session
  before_action :authenticate_request

  def index
    @tickets = Ticket.all
    render json: @tickets
  end

  def show
    @event = Event.find(params[:event_id])
    render json: @ticket
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
    if current_user.role == 'organizer'
      @ticket = current_user.tickets.create(ticket_params)
      render json: @ticket
    else
      flash[:error] = 'You must have the organizer role to create tickets.'
      redirect_to root_path, status: :unprocessable_entity
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

  def destroy
    @ticket = Ticket.find(params[:id])
    @ticket.destroy
    redirect_to root_path, status: :see_other
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
    params.permit(:name, :price, :event_id, :user_id)
  end
end
