class CommentsController < ApplicationController
  def index
    @commentable = find_commentable
    @comments = @commentable.comments
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def create
    @commentable = find_commentable
    @comment = @commentable.comments.build(params[:comment])
    @comment.user_id = current_user.id

    if @comment.save
      redirect_to :id => nil
    else
      redirect_to @commentable, notice: "Comment can't be blank"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
  end

  private
  def find_commentable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.contatnize.find(value)
      end
    end
    nil
  end
  def comment_params
    params.require(:comment).permit(:chat, :user_id)
  end

end
