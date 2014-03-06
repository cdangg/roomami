class WelcomeController < ApplicationController
	before_filter :require_login, :only => :secret

	def index
	end

  def show
    @user = User.find(params[:id])
  end
end
