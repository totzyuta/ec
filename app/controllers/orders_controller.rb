class OrdersController < ApplicationController
  def show
    if @order = Order.find_by(orderId: params[:orderId])
      obj = { result: true, data: {} }
      obj["data"] = @order.attributes
      render json: obj, status: 200
    else
      obj = { result: false, data: {} }
      render json: obj, status: 404
    end 
  end
end
