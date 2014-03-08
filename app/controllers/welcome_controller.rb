class WelcomeController < ApplicationController
	before_filter :require_login, :only => :secret
	before_filter :ensure_logged_in, :except => :index

	def index
	end

  def show

    if current_user.houses.empty?
      redirect_to houses_path
    elsif params[:house_id]
      @house = House.find(params[:house_id])
    else
      @house = current_user.houses.first
    end

    if current_user
      @houses = current_user.houses
    end
      @comments = Comment.all.order("created_at DESC")
  end
end
