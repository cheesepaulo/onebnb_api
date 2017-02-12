FactoryGirl.define do
  factory :reservation do
    property
    user
    checkin_date Time.now - 10.day
    checkout_date Time.now + 10.day
    status { rand(0..3) } # :active, :pending, :inactive, :blocked
    evaluation FFaker::Boolean::maybe
  end
end
