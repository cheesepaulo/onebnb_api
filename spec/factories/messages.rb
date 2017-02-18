FactoryGirl.define do
  factory :message do
    body FFaker::Lorem.paragraph
    user
    talk
  end
end
