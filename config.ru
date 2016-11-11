require 'sinatra/base'

require './controllers/account_controller'
require './controllers/application_controller'
require './controllers/products_controller'

# this is data for the models folder

require './models/accounts'
require './models/application'
require './models/products'

#mapping controllers to routes

map ('/') { run ApplicationController}
map ('/account') { run AccountController}
