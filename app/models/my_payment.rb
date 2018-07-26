# == Schema Information
#
# Table name: my_payments
#
#  id         :bigint(8)        not null, primary key
#  email      :string
#  ip         :string
#  status     :string
#  fee        :decimal(6, 2)
#  paypal_id  :string
#  total      :decimal(10, 2)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class MyPayment < ActiveRecord::Base
	include AASM
	aasm column: "status" do 
		state :created, initial: true
		state :payed
		state :failed	

		#definir los eventos
		event :pay do  #intentamos pagar el carrito
			transitions from: :created, to: :payed
		end
	end
end
