FactoryGirl.define do
  factory :comment do
    body "MyText"
    user_id 1
    property_id 1
    status 1
  end
end
