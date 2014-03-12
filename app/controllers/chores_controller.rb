class ChoresController < ApplicationController
  before_filter :ensure_logged_in
  before_filter :contain_house?

  def index
    if params[:house_id]
      @house = House.find(params[:house_id])
    else
      @house = current_user.houses.first
    end
    @chores = @house.chores.pending
  end

  def new
    @house = House.find(params[:house_id])
    @chore = @house.chores.new()
  end

  def create
    @chore = Chore.new(chore_params)
    @chore.user_id = current_user.id

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
    @chore.status = false
    @chore.save
  end

  def complete_task
    @house = House.find(params[:house_id])
    @chore = Chore.find(params[:chore_id])
    @chore.status = true
    @chore.save
    redirect_to chores_path
  end

  def edit
    @chore = Chore.find(params[:id])
    @house = House.find(params[:house_id])
  end

  def destroy
    @chore = Chore.find(params[:id])
    @chore.destroy
    redirect_to chores_path
  end

  private
  def chore_params
    params.require(:chore).permit(:house_id, :name, :status)
  end
end
