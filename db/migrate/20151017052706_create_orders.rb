class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :orderId
      t.datetime :orderDateTime
      t.string :orderUserId
      t.string :orderUserId
      t.string :orderItemId
      t.integer :orderQuantity
      t.string :orderState
      t.string :tag

      t.timestamps null: false
    end
  end
end
