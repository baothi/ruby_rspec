# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contact do
    firstname "John"
    lastname "Doe"
    sequence(:email){ |n| "johndoe#{n}@example.com"}
  end
end
