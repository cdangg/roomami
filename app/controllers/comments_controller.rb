class CommentsController < ApplicationController
  def index
    @comments = Comment.all
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def new
    @house = House.find(params[:house_id])
    @comment = @house.comments.new
  end

  def create
    @house = House.find(params[:comment][:house_id])
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      redirect_to welcome_path(current_user, {house_id: @house.id})
    else
      redirect_to :action => :show, notice: "Comment can't be blank"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :user_id, :house_id)
  end

end
