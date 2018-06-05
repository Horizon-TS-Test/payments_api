class Stores::Paypal #la clase paypal pertenece al modulo Stores
	include PayPal::SDK::REST
	#metodos accesores alamcenar una dato en un objeto y obtenerlo es decir leer y escribir
	attr_accessor :payment # paypal.payment leer
	attr_accessor :return_url
	attr_accessor :cancel_url
	attr_accessor :total 
	attr_accessor :items

	#validates :title, presence: true
	#validates :body, presence: true

	#constructor se ejecuta cuando se instancia la clase
	def initialize(total, items, return_url, cancel_url) #options={}
		self.total = total
		self.items = items #productos
		self.return_url = return_url #options[:return_url]
		self.cancel_url = cancel_url #options[:cancel_url]
		self.payment = nil 
		#{return_url: "/checkout", cancel_url: "/carrito", opcion: 2}
		#options.each {|clave, valor| instance_variable_set("@#{clave}", valor)}
	end
	def process_payment
			#esto viene del api de paypal
		#puts "ingreso a process_payment"
		self.payment = Payment.new(payment_options)
		self.payment
		#puts "pasoo el process_payment"
	end

	#procesamiento del pago con tarjeta
	def process_card(card_data) # card_dat --> hash con toda la informacion de l tarjeta de credito
		options = payment_options #options es todo el hash 
		options[:payer][:payment_method] = "credit_card"
		options[:payer][:funding_instruments] = [{
			credit_card: {
				type: CreditCardValidator::Validator.card_type(card_data[:number]), #visa, mastercard
				number: card_data[:number], #numero de la cuenta
				expire_month: card_data[:expire_month],
				expire_year: card_data[:expire_year],
				cvv2: card_data[:cvv2]
			}
		}]
		self.payment = Payment.new(options)
		self.payment
	end

	def payment_options
		#hash
		puts "ingreso a payment_options"
		
		{
			intent:  "sale",
		  	payer:{
		   		payment_method: "paypal" 
		   	},
		  	transactions:  [
		  		{
		    		item_list:  {
		      			items: self.items
		       		},
		    		amount:  {
		      			total:  (self.total / 100),
		      			currency:  "USD" 
		      		},
		   				description: "Compra de tus productos en nuestra plataforma" 
		   		}
		   	],
		   	redirect_urls: {
		   		return_url: self.return_url, #{}"http://localhost:3000/checkout", # @return_url,
		   		cancel_url: self.cancel_url #{}"http://localhost:3000/carrito" # @cancel_url  
		   	}
		
		}
	end
	

	def self.get_email(payment_id)
		payment = Payment.find(payment_id)
		payment.payer.payer_info.email
	end

	#metodo de clase
	def self.checkout(payer_id, payment_id, &block) #es cobrar
		payment = Payment.find(payment_id)

		if payment.execute(payer_id: payer_id) #PayerID nombre que esta en el url del navegador
			yield if block_given? #ejecuta el bloque devuelve falso si no hay un blooque
		end	
	end

	
end	