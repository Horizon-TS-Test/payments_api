class DropDefaultFromShoppingCart < ActiveRecord::Migration[5.1]
  def change
  	change_column_default(:shopping_carts, :status, nil)
  end
end
