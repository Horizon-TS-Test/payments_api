class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_shopping_cart #se va a ejecutar antes de cualquier visita o cualquier pagina
  private
  	def set_shopping_cart
  		#[:shopping_cart_id] = 2
  		if cookies[:shopping_cart_id].blank?
  			@shopping_cart = ShoppingCart.create!(ip: request.remote_ip)

  			cookies[:shopping_cart_id] = @shopping_cart.id #nuevo carrito
  		else
  			@shopping_cart = ShoppingCart.find(cookies[:shopping_cart_id]) #buscar en la bd el caarrit xq y existe
  		end

  		rescue ActiveRecord::RecordNotFound => e #rescatar un error
  			@shopping_cart = ShoppingCart.create!(ip: request.remote_ip)
  			cookies[:shopping_cart_id] = @shopping_cart.id #nuevo carrito
  	end
end
