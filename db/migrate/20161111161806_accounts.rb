class Accounts < ActiveRecord::Migration[5.0]
  def change
  		create_table :accounts do |table|
  		table.string :username
  		table.string :email
  		table.string :password_hash
  	end
  end
end
