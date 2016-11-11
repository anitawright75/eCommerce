require 'sinatra/base'

require './controllers/account_controller'
require './controllers/application_controller'

# this is data for the models folder

require './models/account'
require './models/products'
require './models/application'

#mapping controllers to routes

map ('/') { run ApplicationController}
map ('/account') { run AccountController}