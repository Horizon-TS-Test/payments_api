Rails.application.routes.draw do

  post "/pagar", to:"payments#create"
  post "/payments/cards", to:"payments#process_card"  # ESTA EN LA VIEW _card_data.haml

  get "/checkout", to: "payments#checkout"

  get "/carrito", to: "shopping_carts#show"


end
