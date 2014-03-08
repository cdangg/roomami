class WelcomeController < ApplicationController
	before_filter :require_login, :only => :secret
	before_filter :ensure_logged_in, :except => :index

	def index
	end

  def show
    @user = User.find(params[:id])
    @complete = Chore.complete
    @pending = Chore.pending
  end
end
