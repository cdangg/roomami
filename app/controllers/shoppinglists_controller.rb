class ShoppinglistsController < ApplicationController
  before_filter :ensure_logged_in
  before_filter :contain_house?

  def index
    if params[:house_id]
      @house = House.find(params[:house_id])
    else
      @house = current_user.houses.first
    end
    @shoppinglists = @house.shoppinglists.pending
  end

  def new
    @house = House.find(params[:house_id])
    @shoppinglist = @house.shoppinglists.new()
  end

  def create
    @shoppinglist = Shoppinglist.new(shoppinglist_params)
    @shoppinglist.user_id = current_user.id

    if @shoppinglist.save
      redirect_to house_shoppinglists_path, :notice => "Shopping list added!"
    else
      render :new, :alert => "Oops, something went wrong"
    end
  end

  def update
    @shoppinglist = Shoppinglist.find(params[:id])

    if @shoppinglist.update_attributes(shoppinglist_params)
      redirect_to house_shoppinglists_path, :notice => "Shopping list updated"
    else
      render :edit, :alert => "Invalid request"
    end
    @shoppinglist.status = false
    @shoppinglist.save
  end

  def complete_task
    @house = House.find(params[:house_id])
    @shoppinglist = Shoppinglist.find(params[:shoppinglist_id])
    @shoppinglist.status = true
    @shoppinglist.save
    # redirect_to house_shoppinglists_path
    redirect_to new_house_expense_path({:house_id => @house.id, :description => @shoppinglist.name })
  end

  def edit
    @shoppinglist = Shoppinglist.find(params[:id])
    @house = House.find(params[:house_id])
  end

  def destroy
    @shoppinglist = Shoppinglist.find(params[:id])
    @shoppinglist.destroy
    redirect_to house_shoppinglists_path
  end

  private
  def shoppinglist_params
    params.require(:shoppinglist).permit(:house_id, :name, :status)
  end
end
