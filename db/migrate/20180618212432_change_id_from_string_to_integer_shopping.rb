class ChangeIdFromStringToIntegerShopping < ActiveRecord::Migration[5.1]
  def change
    change_column :shopping_carts, :id, :integer
  end
end
