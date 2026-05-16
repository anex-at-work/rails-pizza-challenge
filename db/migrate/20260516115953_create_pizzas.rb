class CreatePizzas < ActiveRecord::Migration[8.1]
  def change
    create_table :pizzas do |t|
      t.text :name
      t.integer :price

      t.timestamps
    end
  end
end
