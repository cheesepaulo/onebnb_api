FactoryGirl.define do
  factory :facility do
    wifi FFaker::Boolean::maybe
    washing_machine FFaker::Boolean::maybe
    clothes_iron FFaker::Boolean::maybe
    towels FFaker::Boolean::maybe
    air_conditioning FFaker::Boolean::maybe
    heater FFaker::Boolean::maybe
    refrigerator FFaker::Boolean::maybe
  end
end
