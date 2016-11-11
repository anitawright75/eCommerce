class Products < ActiveRecord::Migration[5.0]
  def change
  	create_table :products do |table|
  		table.string :name
  		table.string :quantity
  		table.string :color
  		table.string :size
  		table.string :price
  	end
  end
end
