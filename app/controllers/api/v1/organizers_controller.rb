class Api::V1::OrganizersController < ApiController
  before_action :authenticate_request

  def index
    @organizers = User.all.where(role: 0)
    render json: @organizers
  end

  def show
    @organizer = User.find(params[:id])
    render json: @organizer
  end

  def create
    @event = current_user.events.create(event_params)
    CrudNotificatonMailer.create_notification(@event).deliver_now
    render json: @event
  end

  def create
    @organizer = User.new(organizer_params)
    respond_to do |format|
      if @organizer.save
        format.json { render json: @organizer }
      else
        format.json { render json: @organizer.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @organizer = User.find_by(id: params[:id])
    if @organizer.update(organizer_params)
      render json: @organizer
    else
      render json: @organizer.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @organizer = User.find_by(id: params[:id])
    @organizer.destroy
    redirect_to root_path, status: :see_other
  end

  def organizer_params
    params.permit(:email, :name, :password, :password_confirmation, :role)
  end
end
