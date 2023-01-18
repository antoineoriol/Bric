# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
#--- cleaning database
puts 'cleaning database'
Product.destroy_all
User.destroy_all
puts 'database cleaned'

# creating users
puts 'creating user'
user1 = User.create(email: 'etest2@test.com', password: 'azerty')
puts 'user created'

# creating legos

lego_sets = [
  { title: 'Lego Star Wars', description: 'Millennium Falcon', price: 849, user: user1 },
  { title: 'Lego Tour Eiffel', description: 'La tour Eiffel', price: 629, user: user1 },
  { title: 'Lego Pyramide', description: 'La grande pyramide de Gizeh', price: 600, user: user1 },
  { title: 'Lego Maison', description: 'La maison en A', price: 179, user: user1 },
  { title: 'Lego Voiture', description: 'Lamborghini Sián FKP 37', price: 449, user: user1 },
  { title: 'Lego Avion', description: "L'avion futuriste", price: 119, user: user1 }
]
lego_photos = ['star_wars.jpg', 'eiffel.jpg', 'pyramide.jpg', 'maison.jpg', 'voiture.jpg', 'avion.jpg']

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
