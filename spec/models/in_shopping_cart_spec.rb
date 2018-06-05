# == Schema Information
#
# Table name: in_shopping_carts
#
#  id               :integer          not null, primary key
#  product_id       :integer
#  shopping_cart_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'rails_helper'

RSpec.describe InShoppingCart, type: :model do
	#Asociacion de pertenencia con el producto o el carrito de compras
	it { should belong_to :product}
	it { should belong_to :shopping_cart}
###########################################
	it { should have_one :user} # el dueno del producto


end
