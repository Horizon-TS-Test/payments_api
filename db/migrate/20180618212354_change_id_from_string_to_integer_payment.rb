class ChangeIdFromStringToIntegerPayment < ActiveRecord::Migration[5.1]
  def change
    change_column :my_payments, :shopping_cart_id, :integer
  end
end
