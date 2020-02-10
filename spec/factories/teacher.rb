FactoryGirl.define do
  factory :teacher do
    first_name { Faker::Name }
    last_name  { Faker::Name }
    email      { Faker::Internet.email }
    password   { Faker::Internet.password }
  end
end
