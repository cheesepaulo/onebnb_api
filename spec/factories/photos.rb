FactoryGirl.define do
  factory :photo do
    property nil
    photo { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'fixtures', 'files', 'file.png')) }
  end
end
