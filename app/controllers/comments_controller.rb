class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user  , only: :destroy
  
  def create
    @topic = Topic.find(params[:topic_id])
    @comment = @topic.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      render :comments
    end
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      render :comments
    end
  end
  
  private
  def comment_params
    params.require(:comment).permit(:content)
  end
  
  def correct_user
    @comment = current_user.comments.find_by(id: params[:id])
    redirect_to root_url if @comment.nil?
  end
end