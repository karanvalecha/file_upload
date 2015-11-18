require 'faker'
FactoryGirl.define do
  factory :user do
    name(Faker::Name.first_name)
    password(Faker::Internet.password)
    sequence(:email, 1) { |n| "test#{n}@example.com" }
  end
end