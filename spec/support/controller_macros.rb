module ControllerMacros
	def login_user # simular inicion de sesion en las pruebaas de controladores
		before :each do
			@request.env["devise.mapping"] = Devise.mappings[:user] #para que devise entienda q estan haciendo un login
			user = 	FactoryGirl.create(:user, email: "u@codigofacilito.com")
			sign_in user
		end
	end

end
