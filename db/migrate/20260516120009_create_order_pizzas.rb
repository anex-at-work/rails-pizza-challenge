class CreateOrderPizzas < ActiveRecord::Migration[8.1]
  def change
    create_table :order_pizzas do |t|
      t.references :order, null: false, type: :text, foreign_key: true
      t.references :pizza, null: false, foreign_key: true
      t.text :size, null: false
      t.float :size_multiplier, null: false, default: 1.0
      t.text :add, null: true
      t.text :remove, null: true

      t.timestamps
    end
  end
end
