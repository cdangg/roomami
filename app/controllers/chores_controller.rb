class ChoresController < ApplicationController
  before_filter :ensure_logged_in
  before_filter :contain_house?
  before_filter :load_house, except: [:index, :destroy]

  def index

    if params[:house_id]
      @house = House.find(params[:house_id])
    else
      @house = current_user.houses.first
    end
    @chore = @house.chores.new()
    @chores = @house.chores.pending.order("chores.created_at desc")
  end

  def new
    @chore = @house.chores.new()
  end

  def create
    @chore = @house.chores.build(chore_params)
    @chore.user_id = current_user.id

    if @chore.save
      respond_to do |format|
        format.html { redirect_to house_chores_path, :notice => "Chore added!" }
        format.json { render json: { chore_name: @chore.name, user_name: current_user.first_name + " " + current_user.last_name, created_at: @chore.created_at, house_id: @house.id, chore_id: @chore.id } }
      end
    else
      render :new, :alert => "Can't add"
    end
  end

  def update
    @chore = Chore.find(params[:id])

    if @chore.update_attributes(chore_params)
      redirect_to house_chores_path, :notice => "Chore updated"
    else
      render :edit, :alert => "Invalid request"
    end
    @chore.status = false
    @chore.save
  end

  def complete_task
    @chore = Chore.find(params[:chore_id])
    @chore.status = true
    @chore.save
    redirect_to house_chores_path
  end

  def edit
    @chore = Chore.find(params[:id])
  end

  def destroy
    @chore = Chore.find(params[:id])
    @chore.destroy
    redirect_to house_chores_path
  end

  private
  def load_house
    @house = House.find(params[:house_id])
  end

  def chore_params
    params.require(:chore).permit(:house_id, :name, :status)
  end
end
