# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(email: "john@mail.com", password: "testing123123", first_name: "John", last_name: "Doe")
# 55.times { Article.create!(title: Faker::Lorem.sentence, content: Faker::Lorem.paragraph, user_id: 1, status: true, published_at: Time.now) }
# 49.times { Article.create!(title: Faker::Lorem.sentence, content: Faker::Lorem.paragraph, user_id: 1, status: true, published_at: Time.now, tag_list: "Play") }