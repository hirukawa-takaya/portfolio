class CommentsController < ApplicationController
  def create
    @topic = Topic.find(params[:topic_id])
    @comment = @topic.comments.build(comment_params)
    @comment.user_id = current_user.id
    
    if @comment.save
      flash[:success] = "コメントしました"
      redirect_to root_path
    else
      redirect_to login_path
    end
  end
  
  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end
