# frozen_string_literal: true

FactoryBot.define do
  factory :bid do
    country { Faker::Address.unique.country_code }
    category { Faker::Lorem.unique.characters(number: 6) }
    channel { Faker::Lorem.unique.characters(number: 2) }
    amount { Faker::Number.decimal(l_digits: 2) }
  end
end
