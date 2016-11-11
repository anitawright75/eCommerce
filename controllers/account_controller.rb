class AccountController < ApplicationController

	@username = ' '

	get '/' do
		#login/registration page info
		erb :login		
	end

	post '/register' do 
		#this will accept the params from a post
		#to create the user and the user info
		#bcrypt info goes here too

		@username = params[:username]
		@password = params[:password]
		@email = params[:email]

		if does_user_exist?(@username) == true
			@account_message = "Existing user...care to login?"
			return erb :login_notice
		end

		password_salt = Bcrypt::Engine.generate_salt
		password_hash = Bcrypt::Engine.hash_secret(@password, password_salt)

		@model = Account.new
		@model.username = @username
		@model.email = @email
		@model.password_hash = password_hash
		@model.password_salt = password_salt
		@model.save

		@account_message = "Thank you for registering, and welcome to my store!"

		session[:user] = @model
		@username = session [:user] [:username]
		#binding pry

		erb :login_notice
	end

	post '/login' do
		# params { :username, :password, :email }
		@username = params[:username]
		@password = params[:password]
		# accept params from a post
		# to check if a user exists
		# and if so, log them in
		if does_user_exist?(@username) == false
			@account_message = "Hmmm...seems that you've already registered with us. Have you forgotten your login information?"
			#binding.pry
			return erb :login_notice
		end
		##=======================
		##MUST COME BACK HERE AND ADD THE DATA TO HAVE THE SHOPPER EITHER MAKE A NEW PASSWORD OR TO BE REDIRECTED TO THE LOGIN AND ENTER THEIR CURRENT PASSWORD.  TWO OPTIONS NEED TO BE CREATED, ONE FOR "FORGOTTEN PASSWORD"  AND THE OTHER FOR "TAKE ME TO THE LOGIN PAGE"

		@model = Account.where(:username => @username).first!
		if @model.password_hash == BCrypt::Engine.hash_secret(@password, @model.password_salt)
			@account_message = "Welcome back!" #see what needs to be added for the name to insert after the welcome message
			session[:user] = @model

			@username = session[:user][:username]
			#binding.pry

			return erb :login_notice
		else
			@account_message = "Sorry, your password did not match. Try again?"
			return erb :login_notice
		end

	end

	get '/logout' do
		# user peaces out
		# set session to nil
		# they will then need to login again
		session[:user] = nil
		@username = nil
		redirect '/'
	end

	get '/supersecret' do
		# our test of user authentication
		# hide some hash/json
		# and only show it to registered, logged in
		# users
		if is_not_authenticated == false
			erb :secret_club
		else
			@account_message = "Sorry but that information doesn't match ours.  Please register at our home page for an account."
			erb :login_notice
		end
	end
end

