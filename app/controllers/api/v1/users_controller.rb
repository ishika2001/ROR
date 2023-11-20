# UsersController
class Api::V1::UsersController < ApiController
  protect_from_forgery with: :null_session

  def index
    @users = User.all
    render json: @users
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      token = AuthenticationTokenService.encode_token(@user.id)
      render json: { token: token }
    else
      render json: { error: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def login
    @user = AuthenticationTokenService.authenticate(params[:email], params[:password])
    if @user
      token = AuthenticationTokenService.encode_token(@user.id)
      render json: { token: token }
    else
      render json: { error: 'Invalid username or password' }, status: :unauthorized
    end
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update(user_params)
      render json: @user
      # else
      #   render json: @user.errors, status: :unprocessable_entity
    end
  end

  # def logout
  #   user = AuthenticationTokenService.authenticate(params[:email], params[:password])
  #   if user
  #     user.authentication_token = nil
  #     user.save
  #     head(:ok)
  #   else
  #     head(:unauthorized)
  #   end
  # end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path, status: :see_other
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation, :role)
  end
end
