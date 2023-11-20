class Api::V1::EventsController < ApiController
  protect_from_forgery with: :null_session
  before_action :authenticate_request

  def index
    @events = Event.all
    render json: @events
  end

  def show
    @event = Event.find(params[:id])
    render json: @event
  end

  def create
    @event = Event.new
    @user = current_user
    @event = current_user.events.build(event_params)
    render json: @event
  end

  # def edit
  #   @event = Event.find(params[:id])
  #   render json: @event
  # end

  def update
    @event = Event.find_by(id: params[:id])
    if @event.update(event_params)
      render json: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to root_path, status: :see_other
  end
  
  private

  def event_params
    params.permit(:title, :date, :time, :venue, :description, :image)
  end
end