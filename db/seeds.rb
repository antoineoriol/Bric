# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
#--- cleaning database
puts 'cleaning database'
Booking.destroy_all
Product.destroy_all
User.destroy_all
puts 'database cleaned'

# creating users
puts 'creating user'
user1 = User.create(email: 'etest2@test.com', password: 'azerty')
puts 'user created'

# creating legos

lego_sets = [
  { title: 'Lego Star Wars',
    description: 'Millennium Falcon',
    address: '47 rue berger 75001',
    city: 'Paris',
    capacity: 7541,
    price: 14
    start_date: Faker::Date.between(from: 2.days.ago, to: Date.today),
    end_date: Faker::Date.between(from: 2.days.from_now, to: 30.days.from_now),
    user: user1 },
  { title: 'Lego Tour Eiffel',
    description: 'La tour Eiffel',
    address: '5 Av. Anatole France 75007',
    city: 'Paris',
    capacity: 10001,
    price: 10,
    start_date: Faker::Date.between(from: 2.days.ago, to: Date.today),
    end_date: Faker::Date.between(from: 2.days.from_now, to: 30.days.from_now),
    user: user1 },
  { title: 'Lego Pyramide',
    description: 'La grande pyramide de Gizeh',
    address: '16 rue du pont neuf 75001',
    city: 'Paris',
    capacity: 1476,
    price: 12,
    start_date: Faker::Date.between(from: 2.days.ago, to: Date.today),
    end_date: Faker::Date.between(from: 2.days.from_now, to: 30.days.from_now),
    user: user1 },
  { title: 'Lego Maison',
    description: 'La maison en A',
    address: '9 rue mansart 75009',
    city: 'Paris',
    capacity: 3955,
    price: 9,
    start_date: Faker::Date.between(from: 2.days.ago, to: Date.today),
    end_date: Faker::Date.between(from: 2.days.from_now, to: 30.days.from_now),
    user: user1 },
  { title: 'Lego Voiture',
    description: 'Lamborghini Sián FKP 37',
    address: '28 rue jean de la fontaine 75016',
    city: 'Paris',
    capacity: 3696,
    price: 18,
    start_date: Faker::Date.between(from: 2.days.ago, to: Date.today),
    end_date: Faker::Date.between(from: 2.days.from_now, to: 30.days.from_now),
    user: user1 },
  { title: 'Lego Avion',
    description: "L'avion futuriste",
    address: '21 rue blondel 75002',
    city: 'Paris',
    capacity: 608,
    price: 10,
    start_date: Faker::Date.between(from: 2.days.ago, to: Date.today),
    end_date: Faker::Date.between(from: 2.days.from_now, to: 30.days.from_now),
    user: user1 },
  { title: 'Lego train',
    description: "Le Poudlard Express",
    address: "59 bis rue jouffroy d'abbans 75017",
    city: 'Paris',
    capacity: 3750,
    price: 9,
    start_date: Faker::Date.between(from: 2.days.ago, to: Date.today),
    end_date: Faker::Date.between(from: 2.days.from_now, to: 30.days.from_now),
    user: user1 },
  { title: 'Le stade Santiago',
    description: "Célèbre plus de 75 ans de matchs légendaires avec l'ensemble Le stade Santiago Bernabéu du Real Madrid",
    address: "3 Bd Michelet, 13008",
    city: 'Marseille',
    capacity: 5876,
    price: 12,
    start_date: Faker::Date.between(from: 2.days.ago, to: Date.today),
    end_date: Faker::Date.between(from: 2.days.from_now, to: 30.days.from_now),
    user: user1 },
  { title: 'Le Taj Mahal',
    description: "Ce superbe modèle à construire et exposer du Taj Mahal est idéal pour les passionnés d’architecture, de voyages et d’histoire.",
    address: "1 Place François Mitterrand, 59777",
    city: 'Lille',
    capacity: 2022,
    price: 14,
    start_date: Faker::Date.between(from: 2.days.ago, to: Date.today),
    end_date: Faker::Date.between(from: 2.days.from_now, to: 30.days.from_now),
    user: user1 },
  { title: 'Le Colisée',
    description: "Ce superbe modèle à construire et exposer du Taj Mahal est idéal pour les passionnés d’architecture, de voyages et d’histoire.",
    address: "1 Place François Mitterrand, 59777",
    city: 'Tours',
    capacity: 9036,
    price: 14,
    start_date: Faker::Date.between(from: 2.days.ago, to: Date.today),
    end_date: Faker::Date.between(from: 2.days.from_now, to: 30.days.from_now),
    user: user1 }
]

lego_photos = ['star_wars.jpg', 'eiffel.jpg', 'pyramide.jpg', 'maison.jpg', 'voiture.jpg', 'avion.jpg', 'train.jpg', 'stade.jpg', 'mahal2.jpg', 'colise.jpg']

puts 'creating legos'
lego_sets.each_with_index do |lego_set, index|
  puts lego_set[:title]
  file = File.open(Rails.root.join("app/assets/images/#{lego_photos[index]}"))
  product = Product.new(lego_set)
  product.photo.attach(io: file, filename: lego_set[:title], content_type: "image/jpg")
  puts 'photo attached'
  product.save!
end
puts 'lego created'
