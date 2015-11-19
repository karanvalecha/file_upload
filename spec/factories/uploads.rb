require 'faker'
FactoryGirl.define do
  factory :upload do
    user
    name "sample.txt"
  end
end