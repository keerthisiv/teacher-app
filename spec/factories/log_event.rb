FactoryGirl.define do
  factory :log_event do
    teacher
    event_type  { %w[check_in check_out].sample }
    event_time  { Time.now }
    description { Faker::Lorem.sentence }
  end
end
