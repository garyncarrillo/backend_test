FactoryBot.define do
  factory :product do
    name { "MyString" }
    description { "MyString" }
    price { "9.99" }
    is_active { true }
  end
end
