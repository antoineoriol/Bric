# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
Product.destroy_all
User.destroy_all
user1 = User.create!(email: 'etest2@test.com', password: 'azerty')

lego_sets = [
  { title: 'Lego Star Wars 75244', description: 'Lego Star Wars 75244', price: 49.99, user: user1 },
  { title: 'Lego tour Eiffel', description: 'Lego tour Eiffel', price: 49.99, user: user1 },
  { title: 'Lego piramide', description: 'Lego piramide', price: 49.99, user: user1 },
  { title: 'Lego maison', description: 'Lego maison', price: 49.99, user: user1 },
  { title: 'Lego voiture', description: 'Lego voiture', price: 49.99, user: user1 },
  { title: 'Lego avion', description: 'Lego avion', price: 49.99, user: user1 },
  { title: 'Lego train', description: 'Lego train', price: 49.99, user: user1 },
  { title: 'Lego bateau', description: 'Lego bateau', price: 49.99, user: user1 }
]

#lego_photo = ['star_wars', 'eiffel', 'piramide']

file = File.open("app/assets/images/star_wars.jpg")

lego_sets.each do |lego_set|
  product = Product.create!(
    title: lego_set['title'],
    description: lego_set['description']
  )
    product.photo.attach(io: file, filename: "lego", content_type: "image/jpg")
    product.save
end
