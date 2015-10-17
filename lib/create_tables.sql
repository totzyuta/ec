CREATE TABLE orders (orderId char(8) NOT NULL PRIMARY KEY, orderDateTime int unsigned, orderUserId char(8), orderItemId char(8), orderQuantity tinyint unsigned, orderState char(5), orderTags char(40));

CREATE TABLE users (userId char(8) NOT NULL PRIMARY KEY, userCompany varchar(255), userDiscountRate tinyint unsigned);

CREATE TABLE items (itemId char(8) NOT NULL PRIMARY KEY, itemSupplier varchar(255), itemStockQuantity smallint unsigned, itemBasePrice mediumint unsigned, itemTags varchar(255));
