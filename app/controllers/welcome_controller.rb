class WelcomeController < ApplicationController
	before_filter :require_login, :only => :secret
	before_filter :ensure_logged_in, :except => :index

	def index
    @user = User.new
	end

  def show

    if current_user.houses.empty?
      redirect_to houses_path
    elsif params[:house_id]
      @house = House.find(params[:house_id])
    else
      @house = current_user.houses.first
    end

    @comment = current_user.comments.new
    @comments = @house.comments.order(created_at: :desc)
  end
end
