# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email    { Faker::Internet.email }
    password { 'password' }


    trait :with_phone do
      phone { Faker::PhoneNumber.phone_number }
    end
  end
end
