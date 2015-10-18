CREATE INDEX idx_orderId ON orders(orderId);
CREATE INDEX idx_orderDateTime ON orders(orderDateTime);
CREATE INDEX idx_orderItemId ON orders(orderItemId);
CREATE INDEX idx_orderQuantity ON orders(orderQuantity);
CREATE INDEX idx_orderState ON orders(orderTags);

CREATE INDEX idx_itemId ON items(itemId);
CREATE INDEX idx_itemSupplier ON items(itemSupplier);
CREATE INDEX idx_itemStockQuantity ON items(itemStockQuantity);
CREATE INDEX idx_itemBasePrice ON items(itemBasePrice);
CREATE INDEX idx_itemTags ON items(itemTags);

CREATE INDEX idx_userId ON items(userId);
CREATE INDEX idx_userCompany ON items(userCompany);
CREATE INDEX idx_userDiscountRate ON items(userDiscountRate);
