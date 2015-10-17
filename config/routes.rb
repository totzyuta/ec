Rails.application.routes.draw do
  get "searchOrder", to: "orders#search", format: :json
end
