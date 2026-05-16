class CreateOrders < ActiveRecord::Migration[8.1]
  def change
    create_table :orders, id: :text do |t|
      t.integer :price
      t.text :discount, null: true
      t.text :promotions, null: true
      t.text :state, default: 'open'

      t.timestamps
    end
  end
end
