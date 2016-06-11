FactoryGirl.define do
  factory :item do
    name { Faker::Commerce.product_name }
    quantity 10
  end
end