class UsersController < ApplicationController

	def initialize
		super
		@ldap = Net::LDAP.new
		@ldap.host = "10.1.1.6"
		@ldap.port = 389
	end

	# GET /login
	def login
	end

	# POST /login
	def authorize
		puts params[:user][:login]
		@ldap.auth params[:user][:login], params[:user][:password]
		if @ldap.bind
			# TODO: Redirect to vehicles
			redirect_to vehicles_url
		else
			redirect_to "/login", :alert => "Bad credentials provided... Please check and try again!"
		end
	end

	
	private

	def user_params
		params.require(:user).permit(:login, :password)
	end
end
