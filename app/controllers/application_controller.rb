class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  	protect_from_forgery with: :exception

  	def ensure_logged_in
  		unless current_user
  			flash[:alert] = "Please log in"
  			redirect_to new_session_path
  		end
  	end

    def contain_house?
      if current_user.houses.empty?
        flash[:alert] = "Please create or find a house"
        redirect_to houses_url(current_user)
      end
    end

  	def current_user
  		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	  end

    helper_method :current_user

	def not_authenticated
	redirect_to login_url, :alert => "First login to access this page."
	end
end
