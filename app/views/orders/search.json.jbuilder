json.result true
json.data do
  json.array! @orders do |order|
    json.orderId order.orderId
    json.orderDateTime order.orderDateTime
    json.orderUserId order.orderTags
    json.orderItemId order.orderItemId
    json.orderQuantity order.orderQuantity
    json.orderState order.orderState
    json.orderTags order.orderTags.split(",")
  end
end
