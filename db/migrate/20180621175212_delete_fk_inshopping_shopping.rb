class DeleteFkInshoppingShopping < ActiveRecord::Migration[5.1]
  def change
    if foreign_key_exists?(:in_shopping_carts, :shopping_cart)
      remove_foreign_key :in_shopping_carts, :shopping_cart
    end
  end
end
