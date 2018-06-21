class Stores::Paypal 
	include PayPal::SDK::REST
	attr_accessor :payment 
	attr_accessor :return_url
	attr_accessor :cancel_url
	attr_accessor :total 
	attr_accessor :items

	def initialize(total, items, return_url, cancel_url) 
		self.total = total
		self.items = items 
		self.return_url = return_url 
		self.cancel_url = cancel_url 
	end

	def process_payment
		self.payment = Payment.new(payment_options)
		self.payment
	end

	def process_card(card_data)
		options = payment_options 
		options[:payer][:payment_method] = "credit_card"
		options[:payer][:funding_instruments] = [{
			credit_card: {
				type: CreditCardValidator::Validator.card_type(card_data[:number]),
				number: card_data[:number], 
				expire_month: card_data[:expire_month],
				expire_year: card_data[:expire_year],
				cvv2: card_data[:cvv2]
			}
		}]
		self.payment = Payment.new(options)
		return self.payment
	end

	def payment_options
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
		   		return_url: self.return_url, 
		   		cancel_url: self.cancel_url   
		   	}
		}
	end

	def self.get_email(payment_id)
		payment = Payment.find(payment_id)
		payment.payer.payer_info.email
	end

	def self.checkout(payer_id, payment_id, &block) 
		payment = Payment.find(payment_id)
		if payment.execute(payer_id: payer_id) 
			yield if block_given? #ejecuta el bloque devuelve falso si no hay un blooque
		end	
	end	
end	