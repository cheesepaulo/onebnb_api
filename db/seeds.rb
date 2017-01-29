a1 = Address.create country: 'Brazil', state: 'São Paulo', city: 'São Paulo'
a2 = Address.create country: 'Brazil', state: 'São Paulo', city: 'São Paulo', street: 'Av Paulista', number: '1'
a3 = Address.create country: 'Brazil', state: 'São Paulo', city: 'São José do Rio Pardo'
a4 = Address.create country: 'Brazil', state: 'São Paulo', city: 'Casa Branca'
a5 = Address.create country: 'Brazil', state: 'São Paulo', city: 'São Paulo', street: 'Av Paulista', number: '1000'

a6 = Address.create country: 'Brazil', state: 'Minas Gerais', city: 'Varginha'
a7 = Address.create country: 'Brazil', state: 'Minas Gerais', city: 'Belo Horizonte'
a8 = Address.create country: 'Brazil', state: 'Minas Gerais', city: 'Machado'
a9 = Address.create country: 'Brazil', state: 'Minas Gerais', city: 'Poços de Caldas'
a10 = Address.create country: 'Brazil', state: 'Minas Gerais', city: 'Montes Claros'

a11 = Address.create country: 'Brazil', state: 'Santa Catarina', city: 'Garopaba'
a12 = Address.create country: 'Brazil', state: 'Santa Catarina', city: 'Joenvile'
a13 = Address.create country: 'Brazil', state: 'Santa Catarina', city: 'Blumenau'
a14 = Address.create country: 'Brazil', state: 'Santa Catarina', city: 'Florianópolis'
a15 = Address.create country: 'Brazil', state: 'Santa Catarina', city: 'São José'

a16 = Address.create country: 'Brazil', state: 'Goiás', city: 'Caldas Novas'
a17 = Address.create country: 'Brazil', state: 'Goiás', city: 'Caldas Novas', street: 'Av. Cel. Bento de Godoy'
a18 = Address.create country: 'Brazil', state: 'Goiás', city: 'Goiania'
a19 = Address.create country: 'Brazil', state: 'Goiás', city: 'Rio Quente'
a20 = Address.create country: 'Brazil', state: 'Goiás', city: 'Oloana'

f1 = Facility.create wifi: true, washing_machine: true
f2 = Facility.create wifi: false, washing_machine: false

u1 = User.create email: 'fake@teste.com', password: '12345678', name: 'Fake Guy'
u2 = User.create email: 'nobody@teste.com', password: '12345678', name: 'Mr Nobody'

p1 = Photo.create(photo: open('db/seed_images/p1.jpg'))
p2 = Photo.create(photo: open('db/seed_images/p2.jpg'))
p3 = Photo.create(photo: open('db/seed_images/p3.jpg'))
p4 = Photo.create(photo: open('db/seed_images/p4.jpg'))
p5 = Photo.create(photo: open('db/seed_images/p5.jpg'))
p6 = Photo.create(photo: open('db/seed_images/p6.jpg'))
p7 = Photo.create(photo: open('db/seed_images/p7.jpg'))
p8 = Photo.create(photo: open('db/seed_images/p8.jpg'))
p9 = Photo.create(photo: open('db/seed_images/p9.jpg'))
p10 = Photo.create(photo: open('db/seed_images/p10.jpg'))
p11 = Photo.create(photo: open('db/seed_images/p11.jpg'))
p12 = Photo.create(photo: open('db/seed_images/p12.jpg'))
p13 = Photo.create(photo: open('db/seed_images/p13.jpg'))
p14 = Photo.create(photo: open('db/seed_images/p14.jpg'))
p15 = Photo.create(photo: open('db/seed_images/p15.jpg'))
p16 = Photo.create(photo: open('db/seed_images/p16.jpg'))
p17 = Photo.create(photo: open('db/seed_images/p17.jpg'))
p18 = Photo.create(photo: open('db/seed_images/p18.jpg'))
p19 = Photo.create(photo: open('db/seed_images/p19.jpg'))
p20 = Photo.create(photo: open('db/seed_images/p20.jpg'))



pro1 = Property.create price: 20, address: a1, facility: f1, user: u1, status: :active, name: "#{a1.city} #{a1.id}"
Property.last.photos << p1
pro2 = Property.create price: 20, address: a2, facility: f1, user: u1, status: :active, name: "#{a2.city} #{a2.id}"
Property.last.photos << p2
pro3 = Property.create price: 20, address: a3, facility: f1, user: u1, status: :active, name: "#{a3.city} #{a3.id}"
Property.last.photos << p3
pro4 = Property.create price: 20, address: a4, facility: f1, user: u1, status: :active, name: "#{a4.city} #{a4.id}"
Property.last.photos << p4
pro5 = Property.create price: 20, address: a5, facility: f1, user: u1, status: :active, name: "#{a5.city} #{a5.id}"
Property.last.photos << p5
pro6 = Property.create price: 20, address: a6, facility: f1, user: u1, status: :active, name: "#{a6.city} #{a6.id}"
Property.last.photos << p6
pro7 = Property.create price: 20, address: a7, facility: f1, user: u1, status: :active, name: "#{a7.city} #{a7.id}"
Property.last.photos << p7
pro8 = Property.create price: 20, address: a8, facility: f1, user: u1, status: :active, name: "#{a8.city} #{a8.id}"
Property.last.photos << p8
pro9 = Property.create price: 20, address: a9, facility: f1, user: u1, status: :active, name: "#{a9.city} #{a9.id}"
Property.last.photos << p9
pro10 = Property.create price: 20, address: a10, facility: f1, user: u1, status: :active, name: "#{a10.city} #{a10.id}"
Property.last.photos << p10

pro11 = Property.create price: 20, address: a11, facility: f2, user: u2, status: :active, name: "#{a11.city} #{a11.id}"
Property.last.photos << p11
pro12 = Property.create price: 20, address: a12, facility: f2, user: u2, status: :active, name: "#{a12.city} #{a12.id}"
Property.last.photos << p12
pro13 = Property.create price: 20, address: a13, facility: f2, user: u2, status: :active, name: "#{a13.city} #{a13.id}"
Property.last.photos << p13
pro14 = Property.create price: 20, address: a14, facility: f2, user: u2, status: :active, name: "#{a14.city} #{a14.id}"
Property.last.photos << p14
pro15 = Property.create price: 20, address: a15, facility: f2, user: u2, status: :active, name: "#{a15.city} #{a15.id}"
Property.last.photos << p15
pro16 = Property.create price: 20, address: a16, facility: f2, user: u2, status: :active, name: "#{a16.city} #{a16.id}"
Property.last.photos << p16
pro17 = Property.create price: 20, address: a17, facility: f2, user: u2, status: :active, name: "#{a17.city} #{a17.id}"
Property.last.photos << p17
pro18 = Property.create price: 20, address: a18, facility: f2, user: u2, status: :active, name: "#{a18.city} #{a18.id}"
Property.last.photos << p18
pro19 = Property.create price: 20, address: a19, facility: f2, user: u2, status: :active, name: "#{a19.city} #{a19.id}"
Property.last.photos << p19
pro20 = Property.create price: 20, address: a20, facility: f2, user: u2, status: :active, name: "#{a20.city} #{a20.id}"
Property.last.photos << p20

Property.reindex
