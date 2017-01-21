FactoryGirl.define do
  factory :property do
    price FFaker.numerify("#.##").to_f
    name FFaker::Lorem.word
    description FFaker::Lorem.paragraph
    user
    accommodation_type { rand(0..2) } # :whole_house, :whole_bedroom :shared_bedroom
    guest_max { rand(1..10) }
    beds { rand(1..10) }
    bedroom { rand(1..10) }
    address
    status { rand(0..3) } # :active, :pending, :inactive, :blocked
    facility
    bathroom { rand(1..10) }
  end
end
