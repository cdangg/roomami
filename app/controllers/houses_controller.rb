class HousesController < ApplicationController
  before_filter :ensure_logged_in

  def index
    @created_houses = current_user.created_houses
    if params[:search]
      @houses = House.where("name LIKE ?", "%#{params[:search]}%")
    end

  end

  def edit
    @house = House.find(params[:id])
  end

  def new
    @house = House.new
  end

  def create
    @house = House.new(house_params)
    @house.admin = current_user
    if @house.save
        redirect_to houses_url, :notice => "House created!"
      else
        render :new
      end
  end

  def show
    @house = House.find(params[:id])
  end

  def update
    @house = House.find(params[:id])
    if @house.update_attributes(house_params)
      redirect_to houses_url
    else
      render :new
    end
  end

  def destroy
    @house = House.find(params[:id])
    @house.destroy
    redirect_to houses_path
  end

  private

  def house_params
    params.require(:house).permit(:name, :address, :city, :bedrooms, :bathrooms, :description, :longitude, :latitude, :image, :remove_image)
  end

end
