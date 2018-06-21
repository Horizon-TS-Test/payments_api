class DeleteFkInshoppingProduct < ActiveRecord::Migration[5.1]
  def change
    if foreign_key_exists?(:in_shopping_carts, :products)
      remove_foreign_key :in_shopping_carts, :products
    end
  end
end
