Rails.application.routes.draw do

  resources :attachments, only: [:create,:destroy,:new,:show] #agreg todas las acciones CRUD
  resources :products
  resources :in_shopping_carts, only: [:create, :destroy] 
  devise_for :users
  #get 'welcome/index'
  		#controlador/accion
post "/emails/create", as: :create_email
post "/pagar", to:"payments#create"
post "/payments/cards", to:"payments#process_card"  # ESTA EN LA VIEW _card_data.haml

get "/carrito", to: "shopping_carts#show"

#metodo get para agregar al carrito 
get "/add/:product_id",as: :add_to_cart, to: "in_shopping_carts#create"
get "/checkout", to: "payments#checkout"

# checkout_path --> retorna "/checkout" ruta relativa
# checkout_url -->  retrna el dominio "codigofacilito.com/checkout" ruta absoluta

get "/descargar/:id", to:"links#download" #  descargar link de productos )= id --customerid

get "/descargar/:id/archivo/:attachment_id", to:"links#download_attachment",as: :download_attachment#  descargar link x achivo =) id --customerids

get "/invalid", to: "welcome#unregistered"

get "/ok", to: "welcome#payment_succed" #cuand el pago se ejecuto

get "/ordenes", to: "ordenes#index"

authenticated :user do
  root 'welcome#index'
end

unauthenticated :user do
	devise_scope :user do
	 	root 'welcome#unregistered', as: :unregistered_root
	end
end	

end
