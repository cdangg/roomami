class UsersController < ApplicationController

  def edit
    @user = User.find(params[:id])
  end

  def new
    @user = current_user || User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      auto_login(@user)
      flash[:success] = "Welcome to roomami"
      redirect_to edit_user_path(current_user)
  	else
  		render :new
  	end

  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      if @user.houses.empty?
        redirect_to houses_path(current_user)
      else
        redirect_to welcome_path(current_user)
      end
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
  end


  private

  def user_params
  	params.require(:user).permit(:first_name, :last_name, :email, :phone_number, :hometown, :bio, :interests, :password, :password_confirmation, :avatar, :remove_avatar)
  end

end
