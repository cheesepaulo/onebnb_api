a1 = Address.create country: "Brazil", state: "Sao Paulo", city: "Sao Paulo"
a2 = Address.create country: "Brazil", state: "São Paulo", city: "São Paulo", street: "Av Paulista", number: "1"
a3 = Address.create country: "Brazil", state: "São Paulo", city: "São José do Rio Pardo"
a4 = Address.create country: "Brazil", state: "São Paulo", city: "Casa Branca"
a5 = Address.create country: "Brazil", state: "São Paulo", city: "São Paulo", street: "Av Paulista", number: "1000"

a6 = Address.create country: "Brazil", state: "Minas Gerais", city: "Varginha"
a7 = Address.create country: "Brazil", state: "Minas Gerais", city: "Belo Horizonte"
a8 = Address.create country: "Brazil", state: "Minas Gerais", city: "Machado"
a9 = Address.create country: "Brazil", state: "Minas Gerais", city: "Poços de Caldas"
a10 = Address.create country: "Brazil", state: "Minas Gerais", city: "Montes Claros"

a11 = Address.create country: "Brazil", state: "Santa Catarina", city: "Garopaba"
a12 = Address.create country: "Brazil", state: "Santa Catarina", city: "Joenvile"
a13 = Address.create country: "Brazil", state: "Santa Catarina", city: "Blumenau"
a14 = Address.create country: "Brazil", state: "Santa Catarina", city: "Florianópolis"
a15 = Address.create country: "Brazil", state: "Santa Catarina", city: "São José"

a16 = Address.create country: "Brazil", state: "Goiás", city: "Caldas Novas"
a17 = Address.create country: "Brazil", state: "Goiás", city: "Caldas Novas", street: "Av. Cel. Bento de Godoy"
a18 = Address.create country: "Brazil", state: "Goiás", city: "Goiania"
a19 = Address.create country: "Brazil", state: "Goiás", city: "Rio Quente"
a20 = Address.create country: "Brazil", state: "Goiás", city: "Oloana"

f1 = Facility.create wifi: true, washing_machine: true
f2 = Facility.create wifi: false, washing_machine: false

u1 = User.create email: "fake@teste.com", password: "12345678", name: "Fake Guy", photo: open("db/seed_images/steve.jpg"), address: a1, confirmed_at: Time.now
u2 = User.create email: "nobody@teste.com", password: "12345678", name: "Mr Nobody", photo: open("db/seed_images/bill.jpeg"), address: a2, confirmed_at: Time.now

c1 = Comment.create body: 'Hey You Im just a little comment to be a example in this awesome APP', user: u1
c2 = Comment.create body: 'Hey You Im just a little comment to be a example in this awesome APP', user: u1
c3 = Comment.create body: 'Hey You Im just a little comment to be a example in this awesome APP', user: u1
c4 = Comment.create body: 'Olá eu sou apenas um pequeno comentário que serve como um exemplo nesse APP incrível \o/', user: u2
c5 = Comment.create body: 'Olá eu sou apenas um pequeno comentário que serve como um exemplo nesse APP incrível \o/', user: u2
c6 = Comment.create body: 'Olá eu sou apenas um pequeno comentário que serve como um exemplo nesse APP incrível \o/', user: u2


p1 = Photo.create(photo: open("db/seed_images/p1.jpg"))
p2 = Photo.create(photo: open("db/seed_images/p2.jpg"))
p3 = Photo.create(photo: open("db/seed_images/p3.jpg"))
p4 = Photo.create(photo: open("db/seed_images/p4.jpg"))
p5 = Photo.create(photo: open("db/seed_images/p5.jpg"))
p6 = Photo.create(photo: open("db/seed_images/p6.jpg"))
p7 = Photo.create(photo: open("db/seed_images/p7.jpg"))
p8 = Photo.create(photo: open("db/seed_images/p8.jpg"))
p9 = Photo.create(photo: open("db/seed_images/p9.jpg"))
p10 = Photo.create(photo: open("db/seed_images/p10.jpg"))
p11 = Photo.create(photo: open("db/seed_images/p11.jpg"))
p12 = Photo.create(photo: open("db/seed_images/p12.jpg"))
p13 = Photo.create(photo: open("db/seed_images/p13.jpg"))
p14 = Photo.create(photo: open("db/seed_images/p14.jpg"))
p15 = Photo.create(photo: open("db/seed_images/p15.jpg"))
p16 = Photo.create(photo: open("db/seed_images/p16.jpg"))
p17 = Photo.create(photo: open("db/seed_images/p17.jpg"))
p18 = Photo.create(photo: open("db/seed_images/p18.jpg"))
p19 = Photo.create(photo: open("db/seed_images/p19.jpg"))
p20 = Photo.create(photo: open("db/seed_images/p20.jpg"))
p21 = Photo.create(photo: open("db/seed_images/p18.jpg"))
p22 = Photo.create(photo: open("db/seed_images/p19.jpg"))
p23 = Photo.create(photo: open("db/seed_images/p20.jpg"))
p24 = Photo.create(photo: open("db/seed_images/p18.jpg"))
p25 = Photo.create(photo: open("db/seed_images/p19.jpg"))
p26 = Photo.create(photo: open("db/seed_images/p20.jpg"))


property = Property.new price: 20, address: a1, facility: f1, user: u1, status: :active, name: "#{a1.city} #{a1.id}", rating: 1, accommodation_type: :whole_house, beds: 2, bedroom: 3, bathroom: 2, guest_max: 5, description: 'É um belo Lugar para se visita'
[p1, p21, p22, p23].each {|photo| property.photos << photo}
[c1, c2, c3, c4, c5, c6].each {|comment| property.comments << comment}
property.save!
property = Property.new price: 20, address: a2, facility: f1, user: u1, status: :active, name: "#{a2.city} #{a2.id}", rating: 4, accommodation_type: :whole_house, beds: 2, bedroom: 3, bathroom: 2, guest_max: 5, description: 'É um belo Lugar para se visita'
[p2, p24, p25, p26].each {|photo| property.photos << photo}
property.save!
property = Property.new price: 20, address: a3, facility: f1, user: u1, status: :active, name: "#{a3.city} #{a3.id}", rating: 1, accommodation_type: :whole_house, beds: 2, bedroom: 3, bathroom: 2, guest_max: 5, description: 'É um belo Lugar para se visita'
property.photos << p3
property.save!
property = Property.new price: 20, address: a4, facility: f1, user: u1, status: :active, name: "#{a4.city} #{a4.id}", rating: 4, accommodation_type: :whole_house, beds: 2, bedroom: 3, bathroom: 2, guest_max: 5, description: 'É um belo Lugar para se visita'
property.photos << p4
property.save!
property = Property.new price: 20, address: a5, facility: f1, user: u1, status: :active, name: "#{a5.city} #{a5.id}", rating: 1, accommodation_type: :whole_house, beds: 2, bedroom: 3, bathroom: 2, guest_max: 5, description: 'É um belo Lugar para se visita'
property.photos << p5
property.save!
property = Property.new price: 20, address: a6, facility: f1, user: u1, status: :active, name: "#{a6.city} #{a6.id}", rating: 4, accommodation_type: :whole_bedroom, beds: 2, bedroom: 3, bathroom: 2, guest_max: 5, description: 'É um belo Lugar para se visita'
property.photos << p6
property.save!
property = Property.new price: 20, address: a7, facility: f1, user: u1, status: :active, name: "#{a7.city} #{a7.id}", rating: 1, accommodation_type: :whole_bedroom, beds: 2, bedroom: 3, bathroom: 2, guest_max: 5, description: 'É um belo Lugar para se visita'
property.photos << p7
property.save!
property = Property.new price: 20, address: a8, facility: f1, user: u1, status: :active, name: "#{a8.city} #{a8.id}", rating: 0, accommodation_type: :whole_bedroom, beds: 3, bedroom: 4, bathroom: 3, guest_max: 4, description: 'É um belo Lugar para se visita'
property.photos << p8
property.save!
property = Property.new price: 20, address: a9, facility: f1, user: u1, status: :active, name: "#{a9.city} #{a9.id}", rating: 5, accommodation_type: :whole_bedroom, beds: 3, bedroom: 4, bathroom: 3, guest_max: 4, description: 'É um belo Lugar para se visita'
property.photos << p9
property.save!
property = Property.new price: 20, address: a10, facility: f1, user: u1, status: :active, name: "#{a10.city} #{a10.id}", rating: 0, accommodation_type: :whole_bedroom, beds: 3, bedroom: 4, bathroom: 3, guest_max: 4, description: 'É um belo Lugar para se visita'
property.photos << p10
property.save!

property = Property.new price: 20, address: a11, facility: f2, user: u2, status: :active, name: "#{a11.city} #{a11.id}", rating: 5, accommodation_type: :whole_bedroom, beds: 3, bedroom: 4, bathroom: 3, guest_max: 4, description: 'É um belo Lugar para se visita'
property.photos << p11
property.save!
property = Property.new price: 20, address: a12, facility: f2, user: u2, status: :active, name: "#{a12.city} #{a12.id}", rating: 5, accommodation_type: :shared_bedroom, beds: 3, bedroom: 4, bathroom: 3, guest_max: 4, description: 'É um belo Lugar para se visita'
property.photos << p12
property.save!
property = Property.new price: 20, address: a13, facility: f2, user: u2, status: :active, name: "#{a13.city} #{a13.id}", rating: 5, accommodation_type: :shared_bedroom, beds: 3, bedroom: 4, bathroom: 3, guest_max: 4, description: 'É um belo Lugar para se visita'
property.photos << p13
property.save!
property = Property.new price: 20, address: a14, facility: f2, user: u2, status: :active, name: "#{a14.city} #{a14.id}", rating: 2, accommodation_type: :shared_bedroom, beds: 3, bedroom: 4, bathroom: 3, guest_max: 4, description: 'É um belo Lugar para se visita'
property.photos << p14
property.save!
property = Property.new price: 20, address: a15, facility: f2, user: u2, status: :active, name: "#{a15.city} #{a15.id}", rating: 2, accommodation_type: :shared_bedroom, beds: 3, bedroom: 4, bathroom: 3, guest_max: 4, description: 'É um belo Lugar para se visita'
property.photos << p15
property.save!
property = Property.new price: 20, address: a16, facility: f2, user: u2, status: :active, name: "#{a16.city} #{a16.id}", rating: 2, accommodation_type: :shared_bedroom, beds: 3, bedroom: 4, bathroom: 3, guest_max: 4, description: 'É um belo Lugar para se visita'
property.photos << p16
property.save!
property = Property.new price: 20, address: a17, facility: f2, user: u2, status: :active, name: "#{a17.city} #{a17.id}", rating: 4, accommodation_type: :shared_bedroom, beds: 4, bedroom: 4, bathroom: 3, guest_max: 4, description: 'É um belo Lugar para se visita'
property.photos << p17
property.save!
property = Property.new price: 20, address: a18, facility: f2, user: u2, status: :active, name: "#{a18.city} #{a18.id}", rating: 1, accommodation_type: :shared_bedroom, beds: 4, bedroom: 4, bathroom: 3, guest_max: 4, description: 'É um belo Lugar para se visita'
property.photos << p18
property.save!
property = Property.new price: 20, address: a19, facility: f2, user: u2, status: :active, name: "#{a19.city} #{a19.id}", rating: 1, accommodation_type: :shared_bedroom, beds: 4, bedroom: 4, bathroom: 3, guest_max: 4, description: 'É um belo Lugar para se visita'
property.photos << p19
property.save!
property = Property.new price: 20, address: a20, facility: f2, user: u2, status: :active, name: "#{a20.city} #{a20.id}", rating: 1, accommodation_type: :shared_bedroom, beds: 4, bedroom: 4, bathroom: 3, guest_max: 4, description: 'É um belo Lugar para se visita'
property.photos << p20
property.save!

Property.reindex
