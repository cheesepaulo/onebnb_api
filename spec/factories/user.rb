# Está factory serve para sempre que precisemos de um record user em um teste nós não precisemos cria-lo durante o teste e correr o risco de errar :)

FactoryGirl.define do
  timestamp = DateTime.parse(2.weeks.ago.to_s).to_time.strftime("%F %T")
  email = FFaker::Internet.email

  factory :user do
    uid          { email }
    email        { email }
    nickname     'Josep'
    provider     email
    confirmed_at timestamp
    created_at   timestamp
    updated_at   timestamp
    password 'secret123'
  end
end
