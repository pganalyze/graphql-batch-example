require 'open-uri'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

categories = (1..5).to_a.map do |num|
  Category.create!(
    name: "Category #{num}",
    slug: "category_#{num}"
  )
end

(1..100).to_a.map do |num|
  event = Event.create!(
    category_id: categories.sample.id,
    name: "Event #{num}",
    start_time: num.days.from_now,
    end_time: num.days.from_now + num.hours
  )

  event.image.attach(io: open('https://www.leighhalliday.com/static/ea552a990ff5a2e2015a2780c127f1aa/cf760/banner.jpg'), filename: 'banner.jpg')

  puts event.name

  event
end