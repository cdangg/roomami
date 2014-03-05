class HousesController < ApplicationController
  before_filter :ensure_logged_in

  def index
    @houses = House.all
  end

  def new
    @house = House.new
  end

  def edit
    @house = House.find(params[:id])
  end

  def create
    @house = House.new(house_params)
    if @house.save
        redirect_to houses_url, :notice => "House created!"
      else
        render :new
      end
  end

  def update
    if @house.update_attributes(house_params)
      redirect_to root_url
    else
      render :new
    end
  end

  def destroy
    @house.destroy
    redirect_to houses_path
  end

  private

  def house_params
    params.require(:house).permit(:name, :address, :city)
  end

end
