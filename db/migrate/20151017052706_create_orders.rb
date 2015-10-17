class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders, id: false do |t|
      t.integer :orderId
      t.datetime :orderDateTime
      t.string :orderUserId
      t.string :orderUserId
      t.string :orderItemId
      t.integer :orderQuantity
      t.string :orderState
      t.string :tag
    end
    execute "ALTER TABLE orders ADD PRIMARY KEY (orderId);"
  end
end
