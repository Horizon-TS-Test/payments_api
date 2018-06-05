# == Schema Information
#
# Table name: links
#
#  id              :integer          not null, primary key
#  product_id      :integer
#  expiration_date :datetime
#  downloads       :integer
#  downloads_limit :integer
#  custom_id       :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  email           :string
#

FactoryGirl.define do
	factory :link do
		expiration_date "2018-05-14 15:18:31"
	    downloads 1
	    downloads_limit 1
	    custom_id nil
	    email "pawt@codigofacilito.com"
	    association :product, factory: :product
	    
 	end
end
