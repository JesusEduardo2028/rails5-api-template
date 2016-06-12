FactoryGirl.define do
  factory :user do
    email "user@gmail.com"
    password "12345678"
    password_confirmation "12345678"
    confirmed_at DateTime.now.in_time_zone
  end
end