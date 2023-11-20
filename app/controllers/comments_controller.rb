# frozen_string_literal: true

# app/controllers/comments_controller.rb
class CommentsController < ApplicationController
  # def index
  #   @comments = Comment.all
  # end

  # def show
  #   @comment = Comment.find(params[:id])
  # end

  # def new
  # end

  def create
    @comment = Comment.new
    @event = Event.find(params[:event_id])
    @comment = @event.comments.build(comment_params)
    @comment.attender_id = current_user.id
    if @comment.save
      redirect_to @event, notice: 'Comment added successfully.'
      # else
      # render :new, status: :unprocessble_entity
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
    params.require(:comment).permit(:description)
  end
end
