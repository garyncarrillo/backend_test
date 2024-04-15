# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "123456789" } 
    password_confirmation { password }
  end
end
