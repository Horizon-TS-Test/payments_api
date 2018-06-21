
class PaymentsController < ApplicationController
	protect_from_forgery except: :create
	include PayPal::SDK::REST
	
	def checkout
		@my_payment = MyPayment.find_by(paypal_id: params[:paymentId]) #paymentId nombre que esta en el url del navegador
		if @my_payment.nil? #si es distinto de null 
			render json: {status: 'ERROR', message:'Por favor verifique la información del pago', data:@my_payment.errors},status: :unprocessable_entity
		else
			Stores::Paypal.checkout(params[:PayerID],params[:paymentId]) do
				@my_payment.update(email: Stores::Paypal.get_email(params[:paymentId]))
				@my_payment.pay!
				render json: {status: 'SUCCESS', message:'Se procesó el pago con Paypal', data:@my_payment},status: :ok
				return
			end
			render json: {status: 'ERROR', message:'Hubo un error al procesar el pago', data:@my_payment.errors},status: :unprocessable_entity
			return
		end
	end

	def process_card
		products = params['productos']
		h = convetirHash(products['items'])
		total = products['total'] 
		items = h
		return_url = products['return_url']
		cancel_url = products['cancel_url']
		tarjeta_datos = params['tarjeta']
		paypal_helper = Stores::Paypal.new(total, items, return_url, cancel_url)
		if paypal_helper.process_card(tarjeta_datos).create
			@my_payment = MyPayment.create!(paypal_id: paypal_helper.payment.id, 
									  ip:request.remote_ip,
									  email: tarjeta_datos['email'],
									  shopping_cart_id: params['shopping_id'],
									  total: total ) # id identifica al pago y despues nos permite ejecutar el pago
			@my_payment.pay!
			render json: {status: 'SUCCESS', message:'El pago se realizó correctamente', data:@my_payment},status: :ok
		else
			render json: {status: 'ERROR', message:'Hubo un error al procesar el pago', data:@my_payment.errors},status: :unprocessable_entity
		end
	end


	def create
		h = convetirHash(params['items'])
		total = params['total'] 
		items = h
		return_url = params['return_url']
		cancel_url = params['cancel_url']
		shopping = params['shopping_id']	
		paypal_helper = Stores::Paypal.new(total, items, return_url, cancel_url)
		if paypal_helper.process_payment.create #devuelve vedadero si toda la informcion del pago esta bien
			@my_payment = MyPayment.create!(paypal_id: paypal_helper.payment.id, 
											ip:request.remote_ip, 
											shopping_cart_id: params['shopping_id'], 
											total: total) # id identifica al pago y despues nos permite ejecutar el pago
			render json: {data: paypal_helper.payment.links.find{|v| v.method == "REDIRECT"}.href},status: :ok
		else
			render json: {data: paypal_helper.payment.error.to_yaml}
		end
	end

	def convetirHash(p)
		array = []
		items1 = p.as_json
  		length = items1.size - 1
			for i in(0..length)
				items2 = items1[i].to_h
 				items2.keys.each do|key| 
	    			items2[key.to_sym] = items2.delete(key) 
	    		end
	    		hash = items2
	    		array.push(hash)
  			end
  		return array
	end
end
