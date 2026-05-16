FactoryBot.define do
  factory :order_pizza do
    order
    pizza { Pizza.all.sample || create(:pizza) }

    transient do
      order_pizzas_sizes { [ [ "small", 0.7 ], [ "medium", 1.0 ], [ "large", 1.3 ] ].sample }
      all_ingredients do
        ingredients = [ { name: "Onions", price: 100 }, { name: "Cheese", price: 200 }, { name: "Olives", price: 250 } ]
        cut = [ *0..ingredients.size ].sample
        [ ingredients.take(cut), ingredients.drop(cut) ]
      end
    end

    size { order_pizzas_sizes.first }
    size_multiplier { order_pizzas_sizes.last }
    add { all_ingredients.first if 0.75 < rand }
    remove { all_ingredients.last if 0.75 < rand }
  end
end
