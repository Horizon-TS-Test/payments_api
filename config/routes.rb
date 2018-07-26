Rails.application.routes.draw do
  get "/checkout", to: "payments#checkout"
  post "/pagar", to: "payments#create"
  post "/card", to: "payments#process_card"  
end
