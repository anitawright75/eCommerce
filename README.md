# eCommerce
Tiny Panther
Nov 10th RUBY API structure (this is also going to be put online)

Github and create API rep

git ignore ruby with MIT license

git clone and copy to terminal git remote -v shows you are remoted to GitHub

touch Gemfile
config.ru

mkdir models (this is for the orm/ tables) 
mkdir controllers (this will tell where the information is going. they grab this data from the models folder)
mkdir views 
mkdir public (css, images)
mkdir config
mkdir db

you should have 6 directories and 4 files

subl .

open the Gemfile and type in the following:

source 'https://rubygems.org'

gem 'sinatra'
gem 'json'
gem 'pry'
gem 'mysql2'
gem 'sinatra-activerecord'

group :development do 
	gem 'mysql2'
	
end

group :production do 
	gem 'mysql2'
end

go to terminal and bundle

MODELS FOLDER

touch models/song.rb models/artist.rb

CONTROLLERS FOLDER 

application_controller.rb
(this is the main applications file and it holds data to control the other files)

song_controller.rb
artist_controller.rb 


touch Rakefile

touch config/database.yml

should have 6 directories, 12 files

git add .

git commit -m “  “

git push origin master

MYSQL terminal 

mysql.server start
sudo mysql
password

data for creating the table
still in mysql type :
create database musical_api;

?	go to Rakefile 

	#specify a database to connect to.  this is how rake is allowed to create the tables thru migrations
	#without a db connection you have to create all the tables by hand.

in mysql type:
create user ‘rat pack’@“localhost’ identified by ‘sinatra’;
grant all privileges on musical_api.* to ‘rat pack’@‘localhost’;
flush privileges;  #forces all changes to user accounts immediately

go to config folder database.yml file and add the following:

default :
	adapter: mysql2
	database: musical_api
	username: rat pack
	password: sinatra
	host: localhost

development :
	adapter: mysql2
	database: musical_api
	username: rat pack
	password: sinatra
	host: localhost

production :
	adapter: mysql2
	database: musical_api
	username: rat pack
	password: sinatra
	host: localhost

go to Gemfile and add 
	
	group :development do 
		gem ‘mysql2’
	end

	group :production do 
		gem ‘mysql2’
	end

BUNDLE in the terminal (since we modified the Gemfile)

back to the Rakefile and  add the following:

require ‘zlib’
require ‘sinatra/activerecord’
require ’sinatra/activerecord/rake’

ActiveRecord::Base.establish_connection(
	:database => ‘musical_api’
	:adapter => ‘mysql2’
)
in terminal type 

rake -T
(this is the info for the tables)
rake db:drop (making sure it works, should drop musical_api)
rake db:create (creates it)
rake db:create_migration NAME=songs
rake db:create_migration NAME=artists
rake db:create_migration NAME=accounts

go to the migrate folder and you can see the three files above have been made

go to the accounts.rb file in the migrate folder and type the following under def change:

	create_table :accounts do |table|
		table.string :email
		table.string :password_hash
		table.string :username	
		table.string :about
end
end
end

go to artists file and create a table (using the same info above)
		:name
		:genre

go to songs and create table with 
		:name 
		:artist
		:duration
go to terminal and type:

Rake db:migrate
	(this creates the database tables.  the information has been migrated from the files and converted to tables in mysql)

GO TO the MODELS folder
and add the following file to the other two that already exist:

touch models/account.rb

terminal git status
	git add .
	git commit -m “all of my awesome”
	git push origin master 

back to the MODELS folder

in the song.rb file type the following:

class Song < ActiveRecord::Base

end

(this means you are inheriting all of the objects/methods from ActiveRecord and this same info will show in the migrate folder and the corresponding file.rb)

go to artist.rb and type the following:

class Artist < ActiveRecord::Base

end

go to account.rb and type the following:

class Account < ActiveRecord::Base

end

go to Gemfile and add :
gem ‘bcrypt’ (this may take a while to install)

BUNDLE in terminal


go to controllers folder and then, 

	application_controller.rb file and type the following:

class ApplicationController < Sinatra::Base


		@account_message = ""
		@username = ''


		require 'bundler'
		Bundler.require


		ActiveRecord::Base.establish_connection(
			:adapter => 'mysql2',
			:database => 'musical_api'
		)


		set :public_folder, File.expand_path('../../public', __FILE__)
		set :views, File.expand_path('../../views', __FILE__)
		enable :sessions


		not_found do
			erb :not_found	#404 page
		end


		def does_user_exist?(username)
			user = Account.find_by(:username => username.to_s)
			if user
				return true
			else
				return false
			end
		end


		def is_not_authenticated
			session[:user].nil?	#bool
		end

		get '/' do
			erb :home
		end
	end
=========================================

in the config.ru file type the following:

require 'sinatra/base'

require './controllers/account_controller'
require './controllers/application_controller'

#models folder data
require './models/accounts'
require './models/products'

# mapping controllers to routes
map (‘/‘) { run ApplicationController}

===================================


terminal (start server)
bundle exec rackup
go to localhost:9292
	#should see the “welcome” msg from the application_controllers.rb file

back to controllers folder
touch controllers/account_controller. rb and type in the following:

class AccountController < ApplicationController
	get ‘/‘  do
		# login/registration page
	end 
	

	post ‘/ register’ do 

	end 


end 


class AccountController < Application Controller (this will inherit everything under our Application Controller, plus what that controller inherits)    Get this info from GITHUB

get ‘/‘ do 

end 

post ‘/register’ do 
 #accepts bcrypt info 
end 

post ‘/login’ do 
	@ username 
	@password
	@email = params [:emali]
	#accept params from a post 
	to check if a user logs in 
end 

get ‘/logout’ do 
session [:user
 #user logs out 
sets session to nil
need to log in again 
end

get ‘/supersecret’ do 
 	#test of user authentication 
	#hide some hash/json
	#and only show to registered logged in users 

end 

See second 1/2 of the video and the GitHub file for the info to create/drop/update the tables

PUSH UP TO GIT IN THE TERMINAL 
git add .

git commit -m “ account controller/ table making info  “

git push origin master

BUILDING VIEWS  (see video and GitHub for page rendering details!!)

in the terminal view the tree to verify 7 directories 18 files

touch views/layout.erb
touch views/login.erb
touch views/login_notice.erb

go to layout.erb file and type the following

DOCTYPE HTML

<title> Musical API Login/ registration</title>
  add a meta tag to make the page responsive

add H1 tag to the body
Musical API
section tag <%if session [:user] %>

	<%else  %>

	<%  end %>

add <hr>
<%= yield %> 

bundle exec rackup
(renders info to local host)

go to config.ru and map the account to run AccountController

if you get an error message, be sure to check the application_controller.rb file!!
