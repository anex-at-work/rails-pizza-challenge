FactoryBot.define do
  factory :order do
    transient do
      order_pizzas_count { rand(1..7) }
      with_discount { [ true, false ].sample }
      with_promotions { [ true, false ].sample }
    end

    state { :open }
    discount { with_discount ? "SAVE5" : nil }
    promotions { with_promotions ? [ "2FOR1" ] : [] }

    after(:create) do |order, evaluator|
      order.order_pizzas = create_list(
        :order_pizza,
        evaluator.order_pizzas_count,
        order: order
      )
      # Here is where usually better to calculate total price
      order.price = CalculatePrice.new.call(order:)
      order.save
    end

    trait :completed do
      state { :completed }
    end
  end
end
