# == Schema Information
#
# Table name: shopping_carts
#
#  id         :integer          not null, primary key
#  status     :string
#  ip         :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ShoppingCart < ActiveRecord::Base
	include AASM
	has_many :in_shopping_carts
	has_many :products, through: :in_shopping_carts
	has_many :my_payments
	# status = 0 no esta pagado status = 1 pagado
	#enum status: {payed: 1, default: 0}

	aasm column: "status" do 
		state :created, initial: true
		state :payed
		state :failed	

		#definir los eventos
		event :pay do  #intentamos pagar el c arrito
			after do
				#TODO: Mandar los archivos que el usuario compro
				self.generate_links()
			end
			transitions from: :created, to: :payed
		end
	end

	def payment
		begin
			my_payments.payed.first
		rescue Exception =>	e
			return nil
		end
	end

	def generate_links
		puts  "esta en generate_links"
		self.products.each do |product|
			Link.create(expiration_date: DateTime.now + 7.days, product: product, email: payment.email)
			puts "ya se visualiza el link de descarga"
		end


	end

	def items
		self.products.map{|product| product.paypal_form } #paypal_form metodoo que se va a crear en el producto
	end

	#ShoppingCart.payed #query que liste los shopping pgados
	def total
		#suma = 0
		#products.each do |product|
		#	suma +=product.pricing
	#	end
	#	suma
		products.sum(:pricing)
	end
end
