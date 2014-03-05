class ChoresController < ApplicationController
  before_filter :ensure_logged_in

  def index
    @chores = Chore.all
  end

  def new
    @chore = Chore.new
  end

  def create
    @chore = Chore.new(chore_params)

    if @chore.save
      redirect_to chores_path, :notice => "Chore added!"
    else
      render :new, :alert => "Can't add"
    end
  end

  def update
    @chore = Chore.find(params[:id])

    if @chore.update_attributes(chore_params)
      redirect_to chores_path, :notice => "Chore updated"
    else
      render :edit, :alert => "Invalid request"
    end

  end

  def edit
    @chore = Chore.find(params[:id])
  end

  def destroy
    @chore = Chore.find(params[:id])
    @chore.destroy
    redirect_to chores_path
  end

  private
  def chore_params
    params.require(:chore).permit(:house_id, :name, :status, :user_id)
  end
end
