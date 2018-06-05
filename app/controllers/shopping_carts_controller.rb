class ShoppingCartsController < ApplicationController
	def show #este metodo devuelve verdadero si el valoor de la variable status es payed
		if @shopping_cart.payed?
			render "shopping_carts/complete"
			return
		end
	end
end
