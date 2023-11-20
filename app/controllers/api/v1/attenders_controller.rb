class Api::V1::AttendersController < ApiController
  def index
    @attenders = User.all.where(role: 1)
    render json: @attenders
  end

  def show
    @attender = User.find(params[:id])
    @event = Event.find(params[:id])
  end

  def new
    @user = User.new
  end

  def update
    @attender = User.find_by(id: params[:id])
    if @attender.update(attender_params)
      render json: @attender
    else
      render json: @attender.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @attender = User.find_by(id: params[:id])
    @attender.destroy
    redirect_to root_path, status: :see_other
  end

  private

  def attender_params
    params.permit(:email, :name, :password, :password_confirmation, :role)
  end
end
