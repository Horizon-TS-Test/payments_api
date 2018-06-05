class ChangePricingFromDecimalToInteger < ActiveRecord::Migration[5.1]
  def change
  	change_column :products, :pricing, :integer
  end
end
