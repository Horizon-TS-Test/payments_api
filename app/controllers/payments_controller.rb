
class PaymentsController < ApplicationController
	protect_from_forgery except: :create
	include PayPal::SDK::REST
	
	def checkout
		@my_payment = MyPayment.find_by(paypal_id: params[:paymentId]) #paymentId nombre que esta en el url del navegador
		if @my_payment.nil?
			#redirect_to "/carrito"
			puts "aki 1"
		else
			Stores::Paypal.checkout(params[:PayerID],params[:paymentId]) do
				@my_payment.update(email: Stores::Paypal.get_email(params[:paymentId]))
				
				@my_payment.pay!
				render json: {status: 'SUCCESS', message:'Se proceso el pago con Paypal', data:@my_payment},status: :ok
				#redirect_to ok_path, notice: "Se proceso el pago con PayPal"
				
				return
			end
			#redirect_to carrito_path, notice:"Hubo un error al procesar el pago"
			render json: {status: 'ERROR', message:'Hubo un error al procesar el pago', data:@my_payment.errors},status: :unprocessable_entity
		end
	end

	def process_card
		paypal_helper = Stores::Paypal.new(@shopping_cart.total, @shopping_cart.items, return_url: checkout_url, cancel_url: carrito_url)

		if paypal_helper.process_card(params).create
			@my_payment = MyPayment.create!(paypal_id: paypal_helper.payment.id, 
									  ip:request.remote_ip,
									  email: params[:email],
									  shopping_cart_id: cookies[:shopping_cart_id] ) # id identifica al pago y despues nos permite ejecutar el pago
			@my_payment.pay!
			redirect_to carrito_path, notice: "El pago se realizó correctamente"
		else
			redirect_to carrito_path, notice: paypal_helper.payment.error
		end
	end


	def create 
		total = params['total'] 
		items = params['items']
		return_url = params['return_url']
		cancel_url = params['cancel_url']
		params['payment'] = nil

		paypal_helper = Stores::Paypal.new(total, items, return_url, cancel_url)
		
		#puts paypal_helper.to_json
	 	#items1 = {"name"=>"Back End", "sku"=>"item", "price"=>1, "currency"=>"USD", "quantity"=>1}
	 	
	 	#items[0] = {:name=>"Back End", :sku=>":item", :price=>1, :currency=>"USD", :quantity=>1}
	 	#items[1] = {:name=>"Front End", :sku=>":item", :price=>1, :currency=>"USD", :quantity=>1}

	 	#items1 = items[0]
	 	#puts items[0]
	 	#puts items1
	 	items1 = {"name"=>"Back End", "sku"=>"item", "price"=>1, "currency"=>"USD", "quantity"=>1}
		#items1.keys.each do |key|
  		#items1[key.to_sym] = items1.delete(key)

  		items1.keys.each do |key| 
  			items1[key.to_sym] = items1.delete(key) 
  			puts "key"
  			puts key
  			puts "key to sym"
  			puts items1[key.to_sym]
  			puts "key to sym delete"
  			puts items1.delete(key)
  		end

  		puts items1

  			#items1.keys.each { |key| items1[key.to_sym] = items1.delete(key) }
  			#puts "items"
	 		#puts items1
		#end

	 
		
	


		#puts "paypal_helper"
		#if paypal_helper.process_payment.create #devuelve vedadero si toda la informcion del pago esta bien
		#	puts "ingreso al if"
		#	@my_payment = MyPayment.create!(paypal_id: paypal_helper.payment.id, ip:request.remote_ip, shopping_cart_id: cookies[:shopping_cart_id]) # id identifica al pago y despues nos permite ejecutar el pago
		#	puts "inserto en mi taablaa"
		#	render json: {data: paypal_helper.payment.links.find{|v| v.method == "REDIRECT"}.href},status: :ok
		#	#render json: paypal_helper.payment.links.find{|v| v.method == "REDIRECT"}.href
		#	#{status: 'SUCCESS', message:'Se inserto el pago satisfactoriamente', data:@my_payment},status: :ok
		#else
		#	puts "error"
		#	render json: paypal_helper.payment.error.to_yaml
		#end
	end

end
