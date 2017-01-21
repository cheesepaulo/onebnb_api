FactoryGirl.define do
  factory :address do
    country FFaker::Address::country
    state FFaker::AddressBR::state
    city FFaker::AddressBR::city
    neighborhood FFaker::Address::neighborhood
    street FFaker::Address::street_name
    number FFaker::Address::building_number
    zipcode FFaker::AddressBR::zip_code
    latitude FFaker::Geolocation::lat
    longitude FFaker::Geolocation::lng
  end
end
