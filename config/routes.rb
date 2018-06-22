Rails.application.routes.draw do
  get "/checkout", to: "payments#checkout"
  get "/carrito", to: "shopping_carts#show"
  post "/pagar", to: "payments#create"
  post "/payments/cards", to: "payments#process_card"  
end
