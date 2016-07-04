# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
50.times do |n|
  name = Faker::Name.name
  price_tag = Faker::Number.between(100, 10000)
  quantity = Faker::Number.between(10, 100)
  rating = Faker::Number.between(1, 10)
  category_id = Faker::Number.between(1, 10)
  classify = 0
  image = File.open(File.join(Rails.root, "/app/assets/images/food.jpg"))
  Product.create! name: name, category_id: category_id,
    price_tag: price_tag, classify: classify, quantity: quantity,
    rating: rating, image: image
end
