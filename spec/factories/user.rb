#Está factory serve para sempre que precisemos de um record user em um teste nós não precisemos cria-lo durante o teste e correr o risco de errar :)

FactoryGirl.define do
 timestamp = DateTime.parse(2.weeks.ago.to_s).to_time.strftime("%F %T")

 factory :user do
   uid          { FFaker::Lorem.word }
   email        { FFaker::Internet.email }
   nickname     { FFaker::Lorem.word }
   provider     'email'
   confirmed_at timestamp
   created_at   timestamp
   updated_at   timestamp
   password 'secret123'
   description FFaker::Lorem.paragraph
   phone FFaker::PhoneNumber.phone_number
   birthday Time.now - 10.year
 end
end
