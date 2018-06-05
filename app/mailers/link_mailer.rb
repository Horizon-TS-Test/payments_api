class LinkMailer < ActionMailer::Base  # ActionMailer modulos de rails
	#cnfiguraciones
	default from: "downloads@codigofacilito.com"
	
	#enviar mail
	def download_link(link)
		#variable de la clase @link
		@link = link
		@product = link.product
		mail(to: link.email, subject:"Descarga los productos que adquiriste en horizon-ts.com")
	end
end