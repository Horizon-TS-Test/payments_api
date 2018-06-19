class ChangeIdFromStringToIntegerInshopping < ActiveRecord::Migration[5.1]
  def change
    change_column :in_shopping_carts, :shopping_cart_id, :integer
  end
end
