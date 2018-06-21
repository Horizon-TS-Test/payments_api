class DeleteFkPaymentsShopping < ActiveRecord::Migration[5.1]
  def change
    if foreign_key_exists?(:my_payments, :shopping_cart)
      remove_foreign_key :my_payments, :shopping_cart
    end
  end
end
