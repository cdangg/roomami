class CommentsController < ApplicationController
  def index
    @comments = Comment.all
  end

  def show
    @house = House.find(params[:house_id])
    @comments = @house.comments.all
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

    respond_to do |format|
      if @comment.save
        format.html { redirect_to welcome_path(current_user, {house_id: @house.id}) }
        format.js {}
      else
        format.html { redirect_to welcome_path(current_user), notice: "Comment can't be blank" }
        format.js {}
      end
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
