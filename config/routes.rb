Rails.application.routes.draw do
  get "getOrder/:orderId", to: "orders#show", :format => :json
end
