# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :invitation do
    invitation_email { Faker::Internet.email }
  end
end
