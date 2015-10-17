class OrdersController < ApplicationController
  def show
    if @order = Order.find(params[:orderId])
      # result: true
      render json: @order
    else
      # result: false
      # return nil
    end 
  end
end
