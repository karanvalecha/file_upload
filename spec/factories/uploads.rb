require 'faker'
FactoryGirl.define do
  factory :upload do
    user
    name "samples.txt"
  end
end