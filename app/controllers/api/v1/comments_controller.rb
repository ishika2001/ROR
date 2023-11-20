class Api::V1::CommentsController < ApiController
  before_action :authenticate_request

  def index
    @comments = Comment.all
    render json: @comments
  end

  def show
    @comment = Comment.find(params[:id])
    render json: @comment
  end

  def create
    @comment = Comment.new
    @event = Event.find(params[:event_id])
    @comment = @event.comments.build(comment_params)
    @comment.attender_id = current_user.id
    if @comment.save
      render json: @comment, notice: 'Comment added successfully.'
    end
  end

  def update
    @comment = Comment.find_by(id: params[:id])
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @event = Event.find(params[:event_id])
    @comment = @event.comments.find(params[:id])
    @comment.destroy
    redirect_to event_path(@event), notice: 'Comment deleted successfully'
  end

  private

  def comment_params
    params.permit(:description)
  end
end
