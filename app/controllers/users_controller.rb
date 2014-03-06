class UsersController < ApplicationController

  def new
  	@user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
  		redirect_to @user, :notice => "Signed up!"
  	else
  		render :new
  	end
  end

  def update

    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      redirect_to root_url
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
  	params.require(:user).permit(:first_name, :last_name, :email, :phone_number, :hometown, :bio, :interests, :password, :password_confirmation)
  end

end
