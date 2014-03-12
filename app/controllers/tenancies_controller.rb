class TenanciesController < ApplicationController
  def index
    if params[:search]
      @houses = House.where("name LIKE ?", "%#{params[:search]}%")
    else
      @houses = []
    end
  end

  def search
    @houses = House.where("name LIKE?", "%#{params[:search]}%")
    render @houses
  end

  def create
    @tenancy = Tenancy.new
    @tenancy.user = current_user
    @tenancy.house = House.find(params[:house_id])
    if @tenancy.save
      flash[:notice] = "Tenancy created"
      redirect_to params[:after_goto]
    else
      flash.now[:alert] = "Tenancy already exists"
      render :index
    end
  end

  def destroy
    @tenancy = Tenancy.find(params[:id])
    @tenancy.destroy
    redirect_to houses_path
    flash[:notice] = "Tenancy removed"
  end

  def show
  end

  private
  def tenancy_params
    params.permit(:house_id, :user_id, :name, :search)
  end
end
