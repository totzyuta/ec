class OrdersController < ApplicationController
  def show
    if @order = Order.find_by(orderId: params[:orderId])
      # result: true
      render json: @order
    else
      # result: false
      # return nil
      render "Nothing order"
    end 
  end
end
