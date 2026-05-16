FactoryBot.define do
  factory :pizza do
    name { [ "Margherita", "Salami", "Tonno" ].sample }
    price { [ 500, 600, 800 ].sample }

    trait :margherita do
      name { "Margherita" }
      price { 500 }
    end

    trait :salami do
      name { "Salami" }
      price { 600 }
    end

    trait :tonno do
      name { "Tonno" }
      price { 800 }
    end
  end
end
